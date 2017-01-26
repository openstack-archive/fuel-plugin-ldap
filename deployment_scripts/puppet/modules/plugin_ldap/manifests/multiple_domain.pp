define plugin_ldap::multiple_domain (
  $domain                 = $title,
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
  $page_size              = undef,
  $chase_referrals        = undef,
  $ldap_proxy             = undef,
  $ldap_proxy_default     = undef,
  $management_vip         = undef,
  $slapd_config_template  = undef,
  $slapd_conf             = '/etc/ldap/slapd.conf',
){

  $ldap_url = $url

  if $ldap_proxy_default and $ldap_proxy =~ /^[Tt]rue$/ {
    $url_real = "ldap://${management_vip}"

    if $domain in $slapd_config_template {
      if $use_tls =~ /^[Ff]alse$/ {

        concat::fragment { "${domain}_fragment" :
          target  => $slapd_conf,
          content => template('plugin_ldap/slapd_conf.erb'),
          order   => '40',
        }
      }
      elsif $use_tls =~ /^[Tt]rue$/ {

        concat::fragment { "${domain}_tls_fragment" :
          target  => $slapd_conf,
          content => template('plugin_ldap/slapd_tls_conf.erb'),
          order   => '40',
        }

        plugin_ldap::tls { "${domain}_tls_certificate" :
          domain_tls => $domain,
          ca_chain   => $ca_chain,
        }

      }
    }
    $tls = false
  } else {
    $url_real = $url
    $tls = $use_tls ? { /^[Tt]rue$/ => true, default => false }
  }

  plugin_ldap::keystone { $domain :
    domain                 => $domain,
    identity_driver        => $identity_driver,
    url                    => $url_real,
    use_tls                => $tls,
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

}
