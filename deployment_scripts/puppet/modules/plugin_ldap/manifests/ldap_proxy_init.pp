class plugin_ldap::ldap_proxy_init (
  $internal_virtual_ip     = undef,
  $slapd_defaults_match    = '^SLAPD_SERVICES=',
  $slapd_defaults_path     = '/etc/default/slapd',
  $bin_paths               = '/usr/sbin/:/usr/local/bin/:/bin/:/usr/bin',
  $slaptest_run            = 'slaptest -f /etc/ldap/slapd.conf  -F /etc/ldap/slapd.d',
  $slapd_rsyslog           = '/etc/rsyslog.d/slapd.conf',
) {

  $network_metadata = hiera_hash('network_metadata', {})
  $controller_hash  = get_node_to_ipaddr_map_by_network_role(get_nodes_hash_by_roles($network_metadata, ['primary-controller', 'controller']), 'management')
  $controller_nodes = keys($controller_hash)
  $controller_ip    = values($controller_hash)
  $network_scheme   = hiera_hash('network_scheme', {})
  prepare_network_config($network_scheme)
  $local_address    = get_network_role_property('management', 'ipaddr')
  $cidr             = hiera('management_network_range')
  $slapd_defaults_services = "SLAPD_SERVICES=\"ldap://${local_address}\""

  file_line { 'slapd_defaults':
    ensure  => present,
    path    => $slapd_defaults_path,
    line    => $slapd_defaults_services,
    replace => true,
    match   => $slapd_defaults_match,
  } ->

  exec { 'run_slaptest':
    command => $slaptest_run,
    path    => $bin_paths,
    user    => 'openldap',
    group   => 'openldap',
    notify  => Service['slapd'],
  } ->

  service { 'slapd':
    ensure => 'running',
    enable => true,
  }

  service { 'rsyslog':
    ensure => 'running',
    enable => true,
  }

  file { $slapd_rsyslog:
    ensure  => present,
    content => template('plugin_ldap/slapd_rsyslog.erb'),
    notify  => Service['rsyslog'],
  }

  firewall { '255 allow ldap-proxy':
    source      => $cidr,
    destination => $baremetal_ipaddr,
    proto       => 'tcp',
    dport       => '389',
    state       => ['NEW', 'RELATED', 'ESTABLISHED'],
    action      => 'accept',
  } ->

  openstack::ha::haproxy_service { 'slapd':
    internal_virtual_ip    => $internal_virtual_ip,
    ipaddresses            => $controller_ip,
    server_names           => $controller_nodes,
    haproxy_config_options => {
      mode   => 'tcp',
      stats  => 'enable',
      option => ['ldap-check',]
    },
    balancermember_options => 'maxconn 10000 check',
    order       => '180',
    listen_port => '389',
  } ~> Service<| title == 'haproxy' |>

}
