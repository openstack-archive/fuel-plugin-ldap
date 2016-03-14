Puppet::Type.type(:keystone_config).provide(
  :ini_setting_domain,
  :parent => Puppet::Type.type(:ini_setting).provider(:ruby)
) do

  def elements
    return @elements if @elements
    elements = resource[:name].split('/', 3)
    elements.unshift nil unless elements.length >= 3
    elements[0] = nil if elements[0] =~ /default/i
    @elements = {
      :domain  => elements[0],
      :section => elements[1],
      :setting => elements[2..-1].join,
    }
  end

  def section
    elements[:section]
  end

  def setting
    elements[:setting]
  end

  def domain
    elements[:domain]
  end

  def separator
    '='
  end

  # added for backwards compatibility with older versions of inifile
  def file_path
    if elements[:domain]
      "/etc/keystone/domains/keystone.#{@elements[:domain]}.conf"
    else
      '/etc/keystone/keystone.conf'
    end
  end

end
