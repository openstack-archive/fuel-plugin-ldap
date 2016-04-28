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

#. LDAP plugin will not work properly without patch that provides proper work of Keystone
   provides with domains
   during deployment process (see `LP1540305 <https://bugs.launchpad.net/fuel/+bug/1540305>`_).
   Please, download the `patch <https://review.fuel-infra.org/#/c/20152/>`_
   and then, on the Fuel Master node ``replace openstack.rb`` file of the patch with the
   ``/etc/puppet/modules/keystone/lib/puppet/provider/keystone_user/openstack.rb`` file.

  .. note::
    This patch will also be included into maintenance update 1
    for Mirantis OpenStack 8.0; this maintenance update is planned to become GA in May 2016
    timeframe. You can check its availability
   `here <https://docs.mirantis.com/openstack/fuel/fuel-8.0/maintenance-updates.html#maintenance-updates-for-mirantis-openstack-8-0>`_.
