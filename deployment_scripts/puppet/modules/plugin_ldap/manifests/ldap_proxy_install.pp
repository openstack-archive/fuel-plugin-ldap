class plugin_ldap::ldap_proxy_install (
  $custom_slapd_config     = undef,
  $template_slapd_config   = undef,
  $domain_name             = undef,
  $use_tls                 = undef,
  $base_config_label       = 'base_config',
  $slapd_dir               = '/etc/ldap/slapd.d/*',
  $bin_path                = '/bin/:/usr/local/bin/',
  $slapd_config            = '/etc/ldap/slapd.conf',
  $slapd_base_template     = template("plugin_ldap/slapd_base.erb"),
  $slapd_config_template   = template("plugin_ldap/slapd_conf.erb"),
  $slapd_conf_tls_template = template("plugin_ldap/slapd_tls_conf.erb"),
  $slapd_upstart_template  = template("plugin_ldap/slapd_upstart.erb"),

) {

  package { 'ldap-utils':
    ensure => 'installed',
  }

  file { '/etc/init/slapd.conf':
    ensure  => present,
    content => $slapd_upstart_template,
  }

  package { 'slapd':
    ensure => 'installed',
  }

  exec { 'clean_slapd_d':
    command => "rm -rf ${slapd_dir}",
    path    => $bin_path,
  }

  concat { "${slapd_config}" :
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  if $base_config_label in $template_slapd_config {
      concat::fragment { "base_fragment" :
        target  => $slapd_config,
        content => $slapd_base_template,
        order   => '01',
      }
  }

  if $domain_name in $template_slapd_config {
    if ! $use_tls {
      concat::fragment { "${domain_name}_fragment" :
        target  => $slapd_config,
        content => $slapd_config_template,
        order   => '02',
      }
    }
    else {
      concat::fragment { "${domain_name}_tls_fragment" :
        target  => $slapd_config,
        content => $slapd_conf_tls_template,
        order   => '02',
      }
    }
  }

  if $custom_slapd_config {
    concat::fragment { 'ldap_proxy_init' :
      target  => $slapd_config,
      content => $custom_slapd_config,
      order   => '03',
    }
  }

  Package['ldap-utils']->File['/etc/init/slapd.conf']->
  Package['slapd']->Exec['clean_slapd_d']->
  Concat["${slapd_config}"]

}
