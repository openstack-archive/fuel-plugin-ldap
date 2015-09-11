======================================================================
Fuel plugin that allows to use existing ldap as authentication backend
======================================================================

https://blueprints.launchpad.net/fuel/+spec/fuel-with-existed-ldap


Problem description
===================

Currently the OpenStack environment deployed by Fuel only supports SQL for
the Keystone identity backend. In some cases we already have our own LDAP
(eg openLDAP, AD, etc.) authentication service and we prefer not to maintain
two authentication services in the our environment. Therefore, it would be
beneficial to support LDAP identity backend too.


Proposed change
===============

Implement Fuel plugin that will allow to switch identity backend by adding
setting options at cluster wizard page as a trigger which allowing deployers
to choose their own pre-existed LDAP as identity backend.

* Keystone domain_specific_drivers will be enabled once LDAP backend is
  choosed.

* Default keystone domain will be used to store openstack service users.
  SQL will be used as identity backed for default domain.

* New keystone domain will be created. Name of keystone domain is specified
  in LDAP settings. Identity backend driver will be change to LDAP for this
  domain.

* All horizon users will use LDAP as authentication backend.
  Horizon identity API will be switched to V3.

Plugin also add an additional setting block inside cluster setting tab for fill
up LDAP detail connection information include LDAP server administrator
information, connection info, etc.


Alternatives
------------

* Use ReadWrite LDAP connection, which is not recomended due to security
  reasosn.

* Use ReadOnly LDAP connection. Enabling keystone domains is needed, since
  heat requires ReadWrite access to authentication backend.

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
