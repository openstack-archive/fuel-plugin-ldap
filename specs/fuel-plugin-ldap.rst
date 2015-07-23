=====================================================================
Fuel plugin that allows to use existed ldap as authentication backend
=====================================================================

https://blueprints.launchpad.net/fuel/+spec/fuel-with-existed-ldap


Problem description
===================

Currently the OpenStack environment deployed by Fuel only supports SQL for
the Keystone identity backend. In some cases we already have our own LDAP
(eg openLDAP, AD, etc.) authentication service and we prefer not to maintain
two authentication services in the our environment. Therefore, it would be
beneficial to support LDAP identity backend too. Given that the Keystone team
considers SQL as the preferred assignment backend, the idea of LDAP assignment
backend is against it and therefore we prefer using SQL as assignment backend
with no switch option.


Proposed change
===============

Implement Fuel plugin which will allow to switch identity backend by adding
setting options at cluster wizard page as a trigger which allowing deployers
to choose their own identity backend with SQL, or pre-existing LDAP server which
is ReadOnly/ReadWrite. Since Openstack documentation discourages using LDAP with
other connection mode beside read-only, alternative solutions were added and
plugin mode were choosed. Plugin also add an additional setting block inside
cluster setting tab for fill up LDAP detail connection information include LDAP
server administrator information, identity domain scope, connection info, etc.


Alternatives
------------

* Allow Fuel to enable keystone domains. Keystone domains allow to have
  separate configs, including identity and assigment backends, for different
  domains. With multidomains it is possible to keep service users in domain
  with SQL identity backend, while all others in LDAP. In this case ReadWrite
  access for LDAP is NOT mandatory, wich is recomended by Openstack
  Documentation.
  It depends on v3 api, and implementation is targeted for 8.0 release.
  https://mirantis.jira.com/browse/PROD-716

Data model impact
-----------------

The following data will be added to settings:

* The LDAP connection URL and login information.

* Customized LDAP configuration for user and group, include tree DNs, filter,
  object class, CRUD permissions.


REST API impact
---------------

No REST API modifications needed.


Upgrade impact
--------------

I see no objections about upgrades. LDAP connection are based on LDAP
identity driver which is a part of official set of identity drivers. So any
upgrades should be done in a common way.


Security impact
---------------

LDAP traffic exchanged in clear-text could be bad for some customers. It
would be worth to add a section on LDAP over SSL.

Notifications impact
--------------------

None.

Other end user impact
---------------------

Deployer will be able to install Fuel Ldap plugin, which allows to configure
LDAP as identity backend for keystone.


Performance Impact
------------------

None.


Other deployer impact
---------------------

None.


Developer impact
----------------

The Configuration pattern of Keystone with LDAP backend will be different
from original sql backend.

Implementation
==============

Assignee(s)
-----------

Primary assignee:
  vsaienko
  dilyin
  iberezovskiy

QA engineers:
  kromanenko

Mandatory design review:
  sfabel
  aandreev
  bdobrelia

Work Items
----------

* Implement Fuel Plugin

* Implement Puppet manifests

* Testing

* Write documentation


Dependencies
============

None


Testing
=======

* Additional functional tests for UI.

* Additional functional tests for puppet script.

* Additional System tests against a stand alone test environment(with ldap).


Documentation Impact
====================

* The documentation should describe how to set up LDAP for a simple test
  environment.

* The documentation should warn about password expiration for service
  accounts(eg their passwords should nerver expire).


References
==========

http://docs.openstack.org/admin-guide-cloud/content/configuring-keystone-for-
ldap-backend.html

https://wiki.openstack.org/wiki/OpenLDAP
