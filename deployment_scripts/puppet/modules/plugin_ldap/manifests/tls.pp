define plugin_ldap::tls (
  $domain_tls = undef,
  $ca_chain   = undef,
){

  $cacertfile = "/usr/local/share/ca-certificates/cacert-ldap-${domain_tls}.crt"

  if $ca_chain {
    file { $cacertfile:
      ensure  => file,
      mode    => 0644,
      content => $ca_chain,
    }
    ~>
    exec { "$domain_tls" :
      command => '/usr/sbin/update-ca-certificates'
    }
  }

}
