define plugin_ldap::tls (
  $domain_tls,
  $ca_chain,
){

  if $ca_chain {

  $cacertfile = "/usr/local/share/ca-certificates/cacert-ldap-${domain_tls}.crt"$

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
