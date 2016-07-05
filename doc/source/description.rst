
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
Fuel                               9.0
Pre-configured LDAP server
================================== ===============

LDAP server should be pre-deployed and be accessible via Public network
from Controller nodes.
