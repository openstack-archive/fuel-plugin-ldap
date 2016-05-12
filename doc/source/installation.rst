==================
Installation Guide
==================

Installing LDAP plugin
============================================

To install LDAP plugin, follow these steps:

#. Download the plugin from the
   `Fuel Plugins Catalog <https://www.mirantis.com/products/
   openstack-drivers-and-plugins/fuel-plugins/>`_.

#. Copy the plugin on an already installed Fuel Master node (SSH can be used for
   that). If you do not have the Fuel Master node yet, see `Quick Start Guide
   <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-install-guide/install/install_install_fuel_master_node.html>`_::

   # scp ldap-2.0-2.0.0-1.noarch.rpm root@<Fuel_Master_IP>:/tmp

#. Log into the Fuel Master node. Install the plugin::

   # cd /tmp
   # fuel plugins --install ldap-2.0-2.0.0-1.noarch.rpm

#. Check if the plugin was installed successfully

   ::

        # fuel plugins
        id | name         | version  | package_version
        ---|--------------|----------|----------------
        1  | ldap         | 2.0.0    | 3.0.0

#. `MU-1 (Maintenance Update) <https://docs.mirantis.com/openstack/fuel/fuel-8.0/maintenance-updates.html#maintenance-updates-for-mirantis-openstack-8-0>`_ should be installed to provide proper work of keystone providers with domains during deployment process.
