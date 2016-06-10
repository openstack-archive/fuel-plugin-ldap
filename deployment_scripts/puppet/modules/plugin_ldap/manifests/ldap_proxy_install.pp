class plugin_ldap::ldap_proxy_install (
  $domain_name,
  $slapd_custom_config     = undef,
  $slapd_config_template   = undef,
  $use_tls                 = false,
  $base_config_label       = 'base_config',
  $slapd_dir               = '/etc/ldap/slapd.d/*',
  $slapd_config            = '/etc/ldap/slapd.conf',
) {

  if !$domain_name {
    fail('Domain name is required parameter')
  }

  package { 'ldap-utils':
    ensure => 'installed',
  } ->

  file { '/etc/init/slapd.conf':
    ensure  => present,
    content => template('plugin_ldap/slapd_upstart.erb'),
  } ->

  package { 'slapd':
    ensure => 'installed',
  } ->

  exec { 'clean_slapd_d':
    command => "/bin/rm -rf ${slapd_dir}",
  } ->

  concat { "${slapd_config}" :
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  if $base_config_label in $template_slapd_config {
      concat::fragment { "base_fragment" :
        target  => $slapd_config,
        content => template('plugin_ldap/slapd_base.erb'),
        order   => '10',
      }
  }

  if $domain_name in $template_slapd_config {
    if ! $use_tls {
      concat::fragment { "${domain_name}_fragment" :
        target  => $slapd_config,
        content => template('plugin_ldap/slapd_conf.erb'),
        order   => '20',
      }
    }
    else {
      concat::fragment { "${domain_name}_tls_fragment" :
        target  => $slapd_config,
        content => template('plugin_ldap/slapd_tls_conf.erb'),
        order   => '20',
      }
    }
  }

  if $slapd_custom_config {
    concat::fragment { 'ldap_proxy_init' :
      target  => $slapd_config,
      content => $slapd_custom_config,
      order   => '30',
    }
  }
}
