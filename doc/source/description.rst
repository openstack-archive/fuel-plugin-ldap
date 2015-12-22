
LDAP plugin for Fuel
====================

This plugin extends Mirantis OpenStack functionality by adding LDAP
support. It allows to use an existing LDAP server as authentication
backend for Keystone. Enabling this plugin means that all users
except system users will be authenticated against the configured
LDAP server.

Please note that Fuel will not validate the settings, e.g. by
attempting to connect to the LDAP server.

Requirements
------------

================================== ===============
Requirement                        Version/Comment
================================== ===============
Fuel                               7.0
Pre-configured LDAP server
MU (Maintenance Update)            3
================================== ===============
