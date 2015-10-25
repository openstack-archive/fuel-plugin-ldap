Uninstalling LDAP plugin
------------------------

Delete all Environments in which LDAP plugin has been enabled.

#. Uninstall the plugin::

      # fuel plugins --remove ldap==1.0.0

#. Check if the plugin was uninstalled successfully::

      # fuel plugins$
      id | name                      | version  | package_version
      ---|---------------------------|----------|------


