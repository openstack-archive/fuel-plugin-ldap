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

#. LDAP plugin will not work properly without patch that provides proper work of Keystone provides with domains
   during deployment process (see 'LP1540305  <https://bugs.launchpad.net/fuel/+bug/1540305>'_).
   Please, apply the following patch manually on the Fuel Master node.

   After applying, replace '/etc/puppet/modules/keystone/lib/puppet/provider/keystone_user/openstack.rb' file with file from the patch.
   Note that this patch will also be included into maintenance update 1 for Mirantis OpenStack which will become GA in several weeks.
