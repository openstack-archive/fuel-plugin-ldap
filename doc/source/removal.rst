Uninstalling LDAP plugin
------------------------

Delete all environments, in which the LDAP plugin has been enabled.

#. Uninstall the plugin::

      # fuel plugins --remove ldap==3.0.0

#. Check if the plugin was uninstalled successfully::

      # fuel plugins
      id | name | version | package_version | releases
      ---+------+---------+-----------------+---------
