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
  $additional_domains     = $::fuel_settings['ldap']['additional_domains']

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

  file { '/etc/keystone/domains':
    ensure => 'directory',
    owner  => 'keystone',
    group  => 'keystone',
    mode   => '755',
  }

  keystone_config {
    "identity/domain_specific_drivers_enabled": value => 'True';
  }

  plugin_ldap::keystone {$domain: 
    domain                 => $domain,
    identity_driver        => $identity_driver,
    url                    => $url,
    use_tls                => $use_tls,
    ca_chain               => $ca_chain,
    suffix                 => $suffix,
    user                   => $user,
    password               => $password,
    query_scope            => $query_scope,
    user_tree_dn           => $user_tree_dn,
    user_filter            => $user_filter,
    user_objectclass       => $user_objectclass,
    user_id_attribute      => $user_id_attribute,
    user_name_attribute    => $user_name_attribute,
    user_pass_attribute    => $user_pass_attribute,
    user_enabled_attribute => $user_enabled_attribute,
    user_enabled_default   => $user_enabled_default,
    user_enabled_mask      => $user_enabled_mask,
    user_allow_create      => $user_allow_create,
    user_allow_update      => $user_allow_update,
    user_allow_delete      => $user_allow_delete,
    group_tree_dn          => $group_tree_dn,
    group_filter           => $group_filter,
    group_objectclass      => $group_objectclass,
    group_id_attribute     => $group_id_attribute,
    group_name_attribute   => $group_name_attribute,
    group_member_attribute => $group_member_attribute,
    group_desc_attribute   => $group_desc_attribute,
    group_allow_create     => $group_allow_create,
    group_allow_update     => $group_allow_update,
    group_allow_delete     => $group_allow_delete,
}  ~>
  service { 'httpd':
    name     => "$apache::params::service_name",
    ensure   => running,
  }


#Create domains using info from text area 'List of additional Domains'
  if $additional_domains {
    $domains_list = split($additional_domains, '^$')
    plugin_ldap::multiple_domain { $domains_list:
      identity_driver => $identity_driver,
    } 
  }

  file_line { 'OPENSTACK_KEYSTONE_URL':
    path => '/etc/openstack-dashboard/local_settings.py',
    line => "OPENSTACK_KEYSTONE_URL = \"http://${management_vip}:5000/v3/\"",
    match => "^OPENSTACK_KEYSTONE_URL = .*$",
  }  ~> Service ['httpd']

  file_line { 'OPENSTACK_API_VERSIONS':
    path => '/etc/openstack-dashboard/local_settings.py',
    line => "OPENSTACK_API_VERSIONS = { \"identity\": 3 }",
    match => "^# OPENSTACK_API_VERSIONS = {.*$",
  } ~> Service ['httpd']

  file_line { 'OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT':
    path => '/etc/openstack-dashboard/local_settings.py',
    line => "OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = True",
    match => "^# OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = .*$",
  }  ~> Service ['httpd']
}
