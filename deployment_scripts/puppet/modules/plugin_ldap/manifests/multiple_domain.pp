define plugin_ldap::multiple_domain (
  $domain_info     = $title,
  $identity_driver = undef
){
  $domain_params_hash = parse_it($domain_info)
  plugin_ldap::keystone { "$domain_params_hash['domain']" :
    domain                 => $domain_params_hash['domain'],
    identity_driver        => $identity_driver,
    url                    => $domain_params_hash['url'],
    use_tls                => $domain_params_hash['use_tls'],
    ca_chain               => $domain_params_hash['ca_chain'],
    suffix                 => $domain_params_hash['suffix'],
    user                   => $domain_params_hash['user'],
    password               => $domain_params_hash['password'],
    query_scope            => $domain_params_hash['query_scope'],
    user_tree_dn           => $domain_params_hash['user_tree_dn'],
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
  }

}
