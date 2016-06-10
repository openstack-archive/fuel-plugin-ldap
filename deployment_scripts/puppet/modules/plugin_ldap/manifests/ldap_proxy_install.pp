class plugin_ldap::ldap_proxy_install (
  $custom_slapd_config    = undef,
  $template_slapd_config  = undef,
  $domain_name            = undef,
  $slapd_upstart_template = '/etc/fuel/plugins/ldap-3.0/puppet/modules/plugin_ldap/manifests/templates/slapd_upstart.erb',
  $slapd_dir              = '/etc/ldap/slapd.d/*',
  $bin_path               = '/bin/:/usr/local/bin/',
  $base_config_label        = 'base_config',
  $slapd_config           = '/etc/ldap/slapd.conf',
  $slapd_base_template    = '/etc/fuel/plugins/ldap-3.0/puppet/modules/plugin_ldap/manifests/templates/slapd_base.erb',
  $slapd_config_template  = '/etc/fuel/plugins/ldap-3.0/puppet/modules/plugin_ldap/manifests/templates/slapd_conf.erb',
) {

  package { 'ldap-utils':
    ensure => 'installed',
  }

  file { '/etc/init/slapd.conf':
    ensure  => present,
    content => template($slapd_upstart_template),
  }

  package { 'slapd':
    ensure => 'installed',
  }

  exec { 'clean_slapd_d':
    command => "rm -rf ${slapd_dir}",
    path    => $bin_path,
  }

  concat { '/etc/ldap/slapd.conf' :
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  if $base_config_label in $template_slapd_config {
    concat::fragment { "base_fragment" :
      target  => $slapd_config,
      content => template($slapd_base_template),
    }
  }

  if $domain_name in $template_slapd_config {
    concat::fragment { "${domain}_fragment" :
      target  => $slapd_config,
      content => template($slapd_config_template),
    }
  }

  if $custom_slapd_config {
    concat::fragment { 'ldap_proxy_initt' :
      target  => $slapd_config,
      content => $custom_slapd_config,
    }
  }

  Package['ldap-utils']->File['/etc/init/slapd.conf']->
  Package['slapd']->Exec['clean_slapd_d']->
  Concat['/etc/ldap/slapd.conf']

}
