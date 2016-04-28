===============
Troubleshooting
===============

Checking presence of LDAP domain/users
======================================

To get a list of domains in keystone run the following command on Controller node:

OS_IDENTITY_API_VERSION=3 OS_AUTH_URL=http://192.168.0.2:5000/v3/ openstack domain list

To get a list of users in a domain run the following command on Controller node:

OS_IDENTITY_API_VERSION=3 OS_AUTH_URL=http://192.168.0.2:5000/v3/ openstack user list --quiet --long --domain <domain_name>

 where 'http://192.168.0.2:5000/v3/' is internal keystone url.

Checking LDAP server availability
=================================

To check LDAP server availability run the following command:

ldapsearch -H ldap://<url/ip_address> -x -b dc=<ldap>,dc=<suffix>

LDAP plugin log files
=====================

As LDAP plugin only updates keystone configuration files to check keystone
service look at these log files:

/var/log/apache2/keystone_wsgi_admin_access.log

/var/log/apache2/keystone_wsgi_admin_error.log

/var/log/apache2/keystone_wsgi_main_access.log

/var/log/apache2/keystone_wsgi_main_error.log
