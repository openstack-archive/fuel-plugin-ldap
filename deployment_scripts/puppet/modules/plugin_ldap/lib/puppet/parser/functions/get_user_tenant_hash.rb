module Puppet::Parser::Functions
   newfunction(:get_user_tenant_hash, :type => :rvalue, :doc => <<-EOS
   This function returns hash for keystone_user resource. Hash idems
   depend on Fuel environment settings.
   EOS
   ) do |args|
   users_hash = args[0]
   tenant_name = args[1]
   roles = args[2]
   res = {}
   users_hash.keys.each { |user|
     res["#{user}@#{tenant_name}"] = { :roles => roles }
   }
   res
   end
end
