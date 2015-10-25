==================
Installation Guide
==================

LDAP plugin installation
============================================

To install LDAP plugin, follow these steps:

#. Download the plugin from the
   `Fuel Plugins Catalog <https://www.mirantis.com/products/
   openstack-drivers-and-plugins/fuel-plugins/>`_.

#. Copy the plugin on already installed Fuel Master node; ssh can be used for
   that. If you do not have the Fuel Master node yet, see `Quick Start Guide
   <https://software.mirantis.com/quick-start/>`_::

   # scp ldap-1.0-1.0.0-1.noarch.rpm root@<Fuel_Master_IP>:/tmp

#. Log into the Fuel Master node. Install the plugin::

   # cd /tmp
   # fuel plugins --install ldap-1.0-1.0.0-1.noarch.rpm

#. Check if the plugin was installed successfully::

   # fuel plugins
   id | name         | version  | package_version
   ---|--------------|----------|----------------
   1  | ldap         | 1.0.0    | 2.0.0

LDAP plugin removal
============================================

Delete all Environments in which LDAP plugin has been enabled.

#. Uninstall the plugin:

# fuel plugins --remove ldap==1.0.0

#. Check if the plugin was uninstalled successfully::

   # fuel plugins$
   id | name                      | version  | package_version
   ---|---------------------------|----------|------

