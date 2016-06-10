define plugin_ldap::multiple_domain (
  $domain_info             = $title,
  $identity_driver         = undef,
  $ldap_proxy              = undef,
  $management_vip          = undef,
  $template_slapd_configs  = undef,
  $slapd_conf              = '/etc/ldap/slapd.conf',
  $slapd_conf_template     = template("plugin_ldap/slapd_conf.erb"),
  $slapd_conf_tls_template = template("plugin_ldap/slapd_tls_conf.erb"),

){

  $domain_params_hash = parse_it($domain_info)

  $domain                 = $domain_params_hash['domain']
  $suffix                 = $domain_params_hash['suffix']
  $user_tree_dn           = $domain_params_hash['user_tree_dn']
  $user                   = $domain_params_hash['user']
  $password               = $domain_params_hash['password']
  $ldap_url               = $domain_params_hash['url']
  $use_tls                = $domain_params_hash['use_tls']
  $ldap_proxy_multidomain = $domain_params_hash['ldap_proxy']
  $ca_chain               = $domain_params_hash['ca_chain']

  if $ldap_proxy_multidomain =~ /^[Tt]rue$/ {
    $url = "ldap://${management_vip}"

    if $domain in $template_slapd_configs {
      if $use_tls =~ /^[Ff]alse$/ {

        concat::fragment { "${domain}_fragment" :
          target  => $slapd_conf,
          content => template($slapd_conf_template)
        }

        $tls = $use_tls

      }
      elsif $use_tls =~ /^[Tt]rue$/ {

        concat::fragment { "${domain}_tls_fragment" :
          target  => $slapd_conf,
          content => template($slapd_conf_tls_template)
        }

        plugin_ldap::tls { "${domain}_tls_certificate" :
          domain_tls => $domain,
          ca_chain   => $ca_chain,
        }

        $tls = 'false'

      }

    }
  }
  else {
    $url = $domain_params_hash['url']
    $tls = $use_tls
  }

  plugin_ldap::keystone { "$domain_params_hash['domain']" :
    domain                 => $domain,
    identity_driver        => $identity_driver,
    url                    => $url,
    use_tls                => $tls,
    ca_chain               => $ca_chain,
    suffix                 => $suffix,
    user                   => $user,
    password               => $password,
    query_scope            => $domain_params_hash['query_scope'],
    user_tree_dn           => $user_tree_dn,
    user_filter            => $domain_params_hash['user_filter'],
    user_objectclass       => $domain_params_hash['user_objectclass'],
    user_id_attribute      => $domain_params_hash['user_id_attribute'],
    user_name_attribute    => $domain_params_hash['user_name_attribute'],
    user_pass_attribute    => $domain_params_hash['user_pass_attribute'],
    user_enabled_attribute => $domain_params_hash['user_enabled_attribute'],
    user_enabled_default   => $domain_params_hash['user_enabled_default'],
    user_enabled_mask      => $domain_params_hash['user_enabled_mask'],
    user_allow_create      => $domain_params_hash['user_allow_create'],
    user_allow_update      => $domain_params_hash['user_allow_update'],
    user_allow_delete      => $domain_params_hash['user_allow_delete'],
    group_tree_dn          => $domain_params_hash['group_tree_dn'],
    group_filter           => $domain_params_hash['group_filter'],
    group_objectclass      => $domain_params_hash['group_objectclass'],
    group_id_attribute     => $domain_params_hash['group_id_attribute'],
    group_name_attribute   => $domain_params_hash['group_name_attribute'],
    group_member_attribute => $domain_params_hash['group_member_attribute'],
    group_desc_attribute   => $domain_params_hash['group_desc_attribute'],
    group_allow_create     => $domain_params_hash['group_allow_create'],
    group_allow_update     => $domain_params_hash['group_allow_update'],
    group_allow_delete     => $domain_params_hash['group_allow_delete'],
    page_size              => $domain_params_hash['page_size'],
    chase_referrals        => $domain_params_hash['chase_referrals'],
  }

}
