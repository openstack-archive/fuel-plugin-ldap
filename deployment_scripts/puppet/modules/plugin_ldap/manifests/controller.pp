class plugin_ldap::controller {

  include ::apache::params

  $management_vip             = hiera('management_vip')

  ## if AD is used, in order to properly display if account is enabled or disabled
  ## additional parameters need to be set.
  if $::fuel_settings['ldap']['user_enabled_attribute'] == 'userAccountControl' {
    $user_enabled_default = 512
    $user_enabled_mask   = 2
  }

  $identity_driver        = 'keystone.identity.backends.ldap.Identity'
  $url                    = $::fuel_settings['ldap']['url']
  $suffix                 = $::fuel_settings['ldap']['suffix']
  $user                   = $::fuel_settings['ldap']['user']
  $password               = $::fuel_settings['ldap']['password']
  $query_scope            = $::fuel_settings['ldap']['query_scope']
  $user_tree_dn           = $::fuel_settings['ldap']['user_tree_dn']
  $user_filter            = $::fuel_settings['ldap']['user_filter']
  $user_objectclass       = $::fuel_settings['ldap']['user_objectclass']
  $user_id_attribute      = $::fuel_settings['ldap']['user_id_attribute']
  $user_name_attribute    = $::fuel_settings['ldap']['user_name_attribute']
  $user_pass_attribute    = $::fuel_settings['ldap']['user_pass_attribute']
  $user_enabled_attribute = $::fuel_settings['ldap']['user_enabled_attribute']

  $user_allow_create      = false
  $user_allow_update      = false
  $user_allow_delete      = false

  $group_tree_dn          = $::fuel_settings['ldap']['group_tree_dn']
  $group_filter           = $::fuel_settings['ldap']['group_filter']
  $group_objectclass      = $::fuel_settings['ldap']['group_objectclass']
  $group_id_attribute     = $::fuel_settings['ldap']['group_id_attribute']
  $group_name_attribute   = $::fuel_settings['ldap']['group_name_attribute']
  $group_member_attribute = $::fuel_settings['ldap']['group_member_attribute']
  $group_desc_attribute   = $::fuel_settings['ldap']['group_desc_attribute']

  $group_allow_create     = false
  $group_allow_update     = false
  $group_allow_delete     = false

  $domain                 = $::fuel_settings['ldap']['domain']
  $use_tls                = $::fuel_settings['ldap']['use_tls']

  if $use_tls {
    $ca_chain       = pick($::fuel_settings['ldap']['ca_chain'], false)
    $cacertfile     = '/usr/local/share/ca-certificates/cacert-ldap.crt'

    $tls_cacertdir  = $ca_chain ? {
      default => 'None',
      true    => '/etc/ssl/certs',
    }

    if $ca_chain {
      file { $cacertfile:
        ensure  => file,
        mode    => 0644,
        content => $ca_chain,
      }
      ~>
      exec { '/usr/sbin/update-ca-certificates': }
    }
  }

  file { '/etc/keystone/domains':
    ensure => 'directory',
    owner  => 'keystone',
    group  => 'keystone',
    mode   => '755',
  }

  keystone_config {
    "identity/domain_specific_drivers_enabled": value => 'True';
  }

  Keystone_config {
    provider => 'ini_setting_domain',
  }

  keystone_config {
    "${domain}/identity/driver":        value  => $identity_driver;
    "${domain}/ldap/url":                    value => $url;
    "${domain}/ldap/use_tls":                value => $use_tls;
    "${domain}/ldap/tls_cacertdir":          value => $tls_cacertdir;
    "${domain}/ldap/suffix":                 value => $suffix;
    "${domain}/ldap/user":                   value => $user;
    "${domain}/ldap/password":               value => $password;
    "${domain}/ldap/query_scope":            value => $query_scope;
    "${domain}/ldap/user_tree_dn":           value => $user_tree_dn;
    "${domain}/ldap/user_filter":            value => $user_filter;
    "${domain}/ldap/user_objectclass":       value => $user_objectclass;
    "${domain}/ldap/user_id_attribute":      value => $user_id_attribute;
    "${domain}/ldap/user_name_attribute":    value => $user_name_attribute;
    "${domain}/ldap/user_pass_attribute":    value => $user_pass_attribute;
    "${domain}/ldap/user_enabled_attribute": value => $user_enabled_attribute;
    "${domain}/ldap/user_enabled_default":   value => $user_enabled_default;
    "${domain}/ldap/user_enabled_mask":      value => $user_enabled_mask;
    "${domain}/ldap/user_allow_create":      value => $user_allow_create;
    "${domain}/ldap/user_allow_update":      value => $user_allow_update;
    "${domain}/ldap/user_allow_delete":      value => $user_allow_delete;
    "${domain}/ldap/group_tree_dn":          value => $group_tree_dn;
    "${domain}/ldap/group_filter":           value => $group_filter;
    "${domain}/ldap/group_objectclass":      value => $group_objectclass;
    "${domain}/ldap/group_id_attribute":     value => $group_id_attribute;
    "${domain}/ldap/group_name_attribute":   value => $group_name_attribute;
    "${domain}/ldap/group_member_attribute": value => $group_member_attribute;
    "${domain}/ldap/group_desc_attribute":   value => $group_desc_attribute;
    "${domain}/ldap/group_allow_create":     value => $group_allow_create;
    "${domain}/ldap/group_allow_update":     value => $group_allow_update;
    "${domain}/ldap/group_allow_delete":     value => $group_allow_delete;
  } ~>
  service { 'httpd':
    name     => "$apache::params::service_name",
    ensure   => running,
  }

  keystone_domain { "${domain}":
    ensure  => present,
    enabled => true,
  }

  file_line { 'OPENSTACK_KEYSTONE_URL':
    path => '/etc/openstack-dashboard/local_settings.py',
    line => "OPENSTACK_KEYSTONE_URL = \"http://${management_vip}:5000/v3/\"",
    match => "^OPENSTACK_KEYSTONE_URL = .*$",
  } ~> Service ['httpd']

  file_line { 'OPENSTACK_API_VERSIONS':
    path => '/etc/openstack-dashboard/local_settings.py',
    line => "OPENSTACK_API_VERSIONS = { \"identity\": 3 }",
    match => "^# OPENSTACK_API_VERSIONS = {.*$",
  } ~> Service ['httpd']

  file_line { 'OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT':
    path => '/etc/openstack-dashboard/local_settings.py',
    line => "OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = True",
    match => "^# OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = .*$",
  } ~> Service ['httpd']
}
