define plugin_ldap::tls (
  $domain                  = undef,
  $ca_chain                = undef,
){

    $cacertfile = "/usr/local/share/ca-certificates/cacert-ldap-${domain}.crt"

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
