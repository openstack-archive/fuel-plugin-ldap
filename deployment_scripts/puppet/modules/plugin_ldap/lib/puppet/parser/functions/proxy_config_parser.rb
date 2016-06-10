module Puppet::Parser::Functions
  newfunction(:proxy_config_parser, :type => :rvalue, :doc => <<-EOS
This function parses text area of custom openldap proxy configs and
text area of additional domains, returns an array with two elements,
1st element contains all custom openldap proxy configs, 2nd element
contains list of domains that use default (from template) proxy config.
EOS
  ) do |args|

# arg[0]: additional LDAP domains 
# arg[1]: custom openldap proxy configs
# arg[2]: default domain 

base_conf_label = 'base_config'
domains_with_proxy = [base_conf_label]
domains_custom_proxy_configs = {}
slapd_custom_conf = ''
domains_default_conf = []
function_returns = []
array_of_domain_configs = args[0].split(/^$/)
array_of_slapd_configs = args[1].split(/^$/)

#find domain with proxy enabled
array_of_domain_configs.each do |domain_config|
   if domain_config.include? "ldap_proxy=true"
      domain_item = domain_config.slice(/(domain=.*)[^\n]/)
      domain = domain_item.split(/=/)
      domains_with_proxy = domains_with_proxy.push(domain[1])
   end
end
domains_with_proxy = domains_with_proxy.push(args[2])

#find domains with specified custom ldap proxy configs
array_of_slapd_configs.each do |custom_config|
   custom_config_item = custom_config.slice!(/(config_for=.*)[^\n]/)
   custom_config_domain = custom_config_item.split(/=/)
   domains_custom_proxy_configs[custom_config_domain[1]] = custom_config
end

#find domains with custom/default proxy configs
domains_with_proxy.each do |domain|
  if domains_custom_proxy_configs[domain]
    slapd_custom_conf += domains_custom_proxy_configs[domain]
  else
   domains_default_conf = slapd_default_conf.push(domain)
  end

end

function_returns = function_returns.push(slapd_custom_conf)
function_returns = function_returns.push(domains_default_conf)

return function_returns

end
end
