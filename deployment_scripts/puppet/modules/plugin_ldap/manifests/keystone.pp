define plugin_ldap::keystone (
  $domain                 = undef,
  $identity_driver        = undef,
  $url                    = undef,
  $use_tls                = undef,
  $ca_chain               = undef,
  $suffix                 = undef,
  $user                   = undef,
  $password               = undef,
  $query_scope            = undef,
  $user_tree_dn           = undef,
  $user_filter            = undef,
  $user_objectclass       = undef,
  $user_id_attribute      = undef,
  $user_name_attribute    = undef,
  $user_pass_attribute    = undef,
  $user_enabled_attribute = undef,
  $user_enabled_default   = undef,
  $user_enabled_mask      = undef,
  $user_allow_create      = undef,
  $user_allow_update      = undef,
  $user_allow_delete      = undef,
  $group_tree_dn          = undef,
  $group_filter           = undef,
  $group_objectclass      = undef,
  $group_id_attribute     = undef,
  $group_name_attribute   = undef,
  $group_member_attribute = undef,
  $group_desc_attribute   = undef,
  $group_allow_create     = undef,
  $group_allow_update     = undef,
  $group_allow_delete     = undef,
){

  include ::apache::params

  if $use_tls {
    $cacertfile = "/usr/local/share/ca-certificates/cacert-ldap-${domain}.crt"

#  $tls_cacertdir = $ca_chain ? {
#    default => '',
#    true    => '/etc/ssl/certs',
#  }
    if $ca_chain {
      $tls_cacertdir = '/etc/ssl/certs'
    }
    else {
      $tls_cacertdir = ''
    }

    if $ca_chain {
      file { $cacertfile:
        ensure  => file,
        mode    => 0644,
        content => $ca_chain,
      }
      ~>
      exec { "$domain" :
         command => '/usr/sbin/update-ca-certificates'
      }
    }
  }

  file { "/etc/keystone/domains/keystone.${domain}.conf":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    require => File['/etc/keystone/domains'],
  }

  File["/etc/keystone/domains/keystone.${domain}.conf"] -> Keystone_config <||>

  Keystone_config {
    provider => 'ini_setting_domain',
  }

  keystone_config {
    "${domain}/identity/driver":             value => $identity_driver;
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
  }

  keystone_domain { "${domain}":
    ensure  => present,
    enabled => true,
  }

  }
