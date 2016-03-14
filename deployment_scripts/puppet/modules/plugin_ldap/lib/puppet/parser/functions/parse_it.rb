module Puppet::Parser::Functions
  newfunction(:parse_it, :type => :rvalue, :doc => <<-EOS
This function parses text area, create hash and returns values
for keystone domain creation
EOS
  ) do |args|
    splited_text = args[0].split("\n")
    param_hash = {}
    splited_text.each do |item|
      splited_line = item.split('=',2)
      param_hash[splited_line[0]] = splited_line[1]
    end
    return param_hash[args[1]]
  end
end

