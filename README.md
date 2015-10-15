ldap
============

LDAP is a Fuel plugin that allows to use existing LDAP server
as authentication backend for Keystone

This repo contains all necessary files to build LDAP Fuel plugin.
Supported Fuel version is 7.0.

Building the plugin
-------------------

1. Clone the LDAP plugin repo from `https://github.com/stackforge/fuel-plugin-ldap`.
2. Install Fuel Plugin Builder:

    ``pip install fuel-plugin-builder``

3. Execute ``fpb --build <path>`` command, where <path> is the path to the plugin's main
   folder (fuel-plugin-ldap). For example:

   ``fpb --build fuel-plugin-ldap/``

4. The ldap-<x.x.x>.rpm plugin file will be created.

5. Move this file to the Fuel Master node with secure copy (scp):

    ``scp ldap-<x.x.x>.rpm root@:<the_Fuel_Master_node_IP address>:/tmp``
   ``cd /tmp``

6. Install it using the following command:

    ``fuel plugins --install ldap-<x.x.x>.rpm``

6. Plugin is ready to use and can be enabled on the Settings tab of the Fuel web UI.
