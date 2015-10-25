==================
Removal Guide
==================

LDAP plugin removal
============================================

To uninstall LDAP plugin, follow these steps:

1. Delete all Environments in which LDAP plugin has been enabled.
2. Uninstall the plugin:

   # fuel plugins --remove ldap==1.0.0

3. Check if the plugin was uninstalled successfully:

   # fuel plugins
    id | name                      | version  | package_version
    ---|---------------------------|----------|----------------
