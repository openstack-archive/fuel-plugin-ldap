
Configuring LDAP plugin
-----------------------

#. Create a new OpenStack environment to use an existing LDAP server as authentication
   backend for Keystone.
   For more information about environment creation, see `Mirantis OpenStack
   User Guide <http://docs.mirantis.com/openstack
   /fuel/fuel-7.0/user-guide.html#create-a-new-openstack-environment>`_.

#. Open *Settings* tab of the Fuel Web UI, scroll the page down and select
   the *LDAP plugin for Keystone* checkbox:

   .. image:: images/ldap_plugin.png
   .. image:: images/enable_ldap_plugin.png

#. Enter plugin settings into the text fields:

   .. image:: images/settings.png


    ================================== ===============
    Field                              Comment
    ================================== ===============
    LDAP domain                        LDAP domain name.
    LDAP URL                           URL for connecting to the LDAP server, starting with ldap:// or ldaps://
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

#. Continue with environment configuration and deploy it;
   for instructions, see
   `Mirantis OpenStack User Guide <http://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#deploy-changes>`_.
