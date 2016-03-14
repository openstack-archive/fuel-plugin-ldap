define plugin_ldap::multiple_domain (
  $domain_info     = $title,
  $identity_driver = undef
  )
   {
  $dmn = parse_it($domain_info, domain)
    plugin_ldap::keystone { "$dmn" : 
    domain                 => parse_it($domain_info, domain),
    identity_driver        => $identity_driver,
    url                    => parse_it($domain_info, url),
    use_tls                => parse_it($domain_info, use_tls),
    tls_cacertdir          => parse_it($domain_info, tls_cacertdir),
    suffix                 => parse_it($domain_info, suffix),
    user                   => parse_it($domain_info, user),
    password               => parse_it($domain_info, password),
    query_scope            => parse_it($domain_info, query_scope),
    user_tree_dn           => parse_it($domain_info, user_tree_dn),
    user_filter            => parse_it($domain_info, user_filter),
    user_objectclass       => parse_it($domain_info, user_objectclass),
    user_id_attribute      => parse_it($domain_info, user_id_attribute),
    user_name_attribute    => parse_it($domain_info, user_name_attribute),
    user_pass_attribute    => parse_it($domain_info, user_pass_attribute),
    user_enabled_attribute => parse_it($domain_info, user_enabled_attribute),
    user_enabled_default   => parse_it($domain_info, user_enabled_default),
    user_enabled_mask      => parse_it($domain_info, user_enabled_mask),
    user_allow_create      => parse_it($domain_info, user_allow_create),
    user_allow_update      => parse_it($domain_info, user_allow_update),
    user_allow_delete      => parse_it($domain_info, user_allow_delete),
    group_tree_dn          => parse_it($domain_info, group_tree_dn),
    group_filter           => parse_it($domain_info, group_filter),
    group_objectclass      => parse_it($domain_info, group_objectclass),
    group_id_attribute     => parse_it($domain_info, group_id_attribute),
    group_name_attribute   => parse_it($domain_info, group_name_attribute),
    group_member_attribute => parse_it($domain_info, group_member_attribute),
    group_desc_attribute   => parse_it($domain_info, group_desc_attribute),
    group_allow_create     => parse_it($domain_info, group_allow_create),
    group_allow_update     => parse_it($domain_info, group_allow_update),
    group_allow_delete     => parse_it($domain_info, group_allow_delete),
  } ~> Service ['httpd']

}
