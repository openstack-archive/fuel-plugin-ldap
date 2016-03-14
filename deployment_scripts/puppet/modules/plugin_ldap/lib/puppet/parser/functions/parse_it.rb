module Puppet::Parser::Functions
  newfunction(:parse_it, :type => :rvalue, :doc => <<-EOS
This function parses text area, create hash and returns values
for keystone domain creation
EOS
  ) do |args|

    param_hash = {}
    cert_chain = args[0].slice!(/^(ca_chain=-----BEGIN CERTIFICATE-----)(.*[\r\n])+(-----END CERTIFICATE-----[\s\S]*?)$/)

    if cert_chain
      splited_cert_chain = cert_chain.split('=',2)
      param_hash[splited_cert_chain[0]] = splited_cert_chain[1]
    end

    splited_text = args[0].split("\n")
    splited_text.each do |item|
      splited_line = item.split('=',2)
      param_hash[splited_line[0]] = splited_line[1]
    end
    
    return param_hash
  end
end

