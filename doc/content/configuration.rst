============================
LDAP plugin configuration
============================

1. Create an environment and use existing LDAP server as authentication
   backend for Keystone.
   For more information about environment creation, see `Mirantis OpenStack
   User Guide - create a new environment <http://docs.mirantis.com/openstack
   /fuel/fuel-7.0/user-guide.html#create-a-new-openstack-environment>`_.

2. Open *Settings* tab of the Fuel web UI, scroll the page down, find and select 
   *LDAP plugin for Keystone*:

   .. image:: images/ldap_plugin.png
      :width: 50%

   To enable ldap plugin select the plugin checkbox

   .. image:: images/enable_ldap_plugin.png
       :width: 50%

   Fill in form fields:

   .. image:: images/settings.png
      :width: 50%

================================== ===============
Field                              Comment
================================== ===============
LDAP domain                        LDAP domain name.
LDAP URL                           URL for connecting to the LDAP server.
LDAP Suffix                        LDAP server suffix.
LDAP User                          User BindDN to query the LDAP server.
LDAP User Password                 Password for the BindDN to query the LDAP
                                   server.
LDAP Query Scope                   The LDAP scope for queries, this can be
                                   either "one" (onelevel/singleLevel) or 
                                   "sub" (subtree/wholeSubtree).
Users Tree DN                      Search base for users.
User Filter                        LDAP search filter for users.
User Object Class                  LDAP objectclass for users.
User ID Attribute                  LDAP attribute mapped to user id.
User Name Attribute                LDAP attribute mapped to user name.
User Password Attribute            LDAP attribute mapped to password.
User Enabled/Disabled Attribute    LDAP attribute mapped to enabled/disabled.

================================== ===============

3. Adjust other environment settings to your requirements and deploy the
   environment.  For more information, see `Mirantis OpenStack User Guide -
   deploy changes <http://docs.mirantis.com/openstack/fuel/fuel-7.0
   /user-guide.html#deploy-changes>`_.
