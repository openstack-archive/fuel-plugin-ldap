module Puppet::Parser::Functions
  newfunction(:hash_from_domains_list,:type => :rvalue,:doc => <<-EOS
This function parses array, create hash and returns values
for keystone domain creation
EOS
  ) do |args|

  domains_hash = {}
  i=0
  args[0].each do |item|
    i=i+1
    param_hash={}
    cert_chain = item.slice!(/^(ca_chain=-----BEGIN CERTIFICATE-----)(.*[\r\n])+(-----END CERTIFICATE-----[\s\S]*?)$/)

    if cert_chain
      splited_cert_chain = cert_chain.split('=',2)
      param_hash[splited_cert_chain[0]] = splited_cert_chain[1]
    end

    splited_text = item.split("\n")
    splited_text.each do |param|
      splited_line = param.split('=',2)
      if splited_line[0] and splited_line[0] != :undef
        param_hash[splited_line[0]] = splited_line[1]
      end
    end
    domains_hash[param_hash['domain']] = param_hash
  end

  return domains_hash
 end
end