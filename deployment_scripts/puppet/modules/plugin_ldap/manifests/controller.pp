class plugin_ldap::controller {

  include ::apache::params

  $management_vip = hiera('management_vip')

  ## if AD is used, in order to properly display if account is enabled or disabled
  ## additional parameters should be set.
  if $::fuel_settings['ldap']['user_enabled_attribute'] == 'userAccountControl' {
    $user_enabled_default = 512
    $user_enabled_mask    = 2
  }

  $identity_driver        = 'keystone.identity.backends.ldap.Identity'
  $ldap_url               = $::fuel_settings['ldap']['url']
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
  $ldap_proxy_custom_conf = $::fuel_settings['ldap']['ldap_proxy_custom_conf']
  $ldap_proxy             = $::fuel_settings['ldap']['ldap_proxy']

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

  $page_size              = $::fuel_settings['ldap']['page_size']
  $chase_referrals        = pick($::fuel_settings['ldap']['chase_referrals'],'False')

  $domain                 = $::fuel_settings['ldap']['domain']
  $use_tls                = $::fuel_settings['ldap']['use_tls']
  $ca_chain               = pick($::fuel_settings['ldap']['ca_chain'], false)


#Install ldap_proxy and generate slapd.conf file
  if $ldap_proxy {
    $url = "ldap://${management_vip}"

    $proxy_data = proxy_config_parser($additional_domains,$ldap_proxy_custom_conf,$domain)

    class {'plugin_ldap::ldap_proxy_install':
      custom_slapd_config   => $proxy_data[0],
      template_slapd_config => $proxy_data[1],
      domain_name           => $domain,
    }
  }
  else {
    $url = $::fuel_settings['ldap']['url']
    $proxy_data = []
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
    page_size              => $page_size,
    chase_referrals        => $chase_referrals,
  }

#Create domains using info from text area 'List of additional Domains'
  if $additional_domains {
    $domains_list = split($additional_domains, '^$')
    plugin_ldap::multiple_domain { $domains_list:
      identity_driver       => $identity_driver,
      ldap_proxy            => $ldap_proxy,
      management_vip        => $management_vip,
      template_slapd_configs => $proxy_data[1],
    }
  }

#Initialize ldap proxy
  if $ldap_proxy {
    class {'plugin_ldap::ldap_proxy_init':
      internal_virtual_ip => $management_vip,
   }
    Plugin_ldap::Keystone<||> ~>
    service { 'httpd':
    name   => "$apache::params::service_name",
    ensure => running,
    } -> Class['plugin_ldap::ldap_proxy_init']
  }
  else {
    Plugin_ldap::Keystone<||> ~>
    service { 'httpd':
      name   => "$apache::params::service_name",
      ensure => running,
    }
  }

  file_line { 'OPENSTACK_KEYSTONE_URL':
    path  => '/etc/openstack-dashboard/local_settings.py',
    line  => "OPENSTACK_KEYSTONE_URL = \"http://${management_vip}:5000/v3/\"",
    match => "^OPENSTACK_KEYSTONE_URL = .*$",
    tag   => 'ldap-horizon',
  }

  file_line { 'OPENSTACK_API_VERSIONS':
    path  => '/etc/openstack-dashboard/local_settings.py',
    line  => "OPENSTACK_API_VERSIONS = { \"identity\": 3 }",
    match => "^# OPENSTACK_API_VERSIONS = {.*$",
    tag   => 'ldap-horizon',
  }

  file_line { 'OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT':
    path  => '/etc/openstack-dashboard/local_settings.py',
    line  => "OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = True",
    match => "^# OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = .*$",
    tag   => 'ldap-horizon',
  }

  File_Line<| tag == 'ldap-horizon'|> ~> Service['httpd']

}
