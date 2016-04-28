
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

   Specify domain name, LDAP URL, LDAP suffix:

   .. image:: images/ldap_settings.png

   Enable TLS use and put certificate if it is needed:

   .. image:: images/tls_settings.png

   Specify LDAP user, password and other settings:

   .. image:: images/user_ldap_settings.png

   To use LDAP groups provide settings for it:

   .. image:: images/group_ldap_settings.png

   Fields description:

    ================================== ===============
    Field                              Comment
    ================================== ===============
    Domain name                        Name of the Keystone domain.
    LDAP URL                           URL for connecting to the LDAP server.
    LDAP Suffix                        LDAP server suffix.
    Use TLS                            Enable TLS for communicating with the LDAP server.
    CA Chain                           CA trust chain in PEM format.

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
    Groups Tree DN                     Search base for groups.
    Group Filter                       LDAP search filter for groups.
    Group Object Class                 LDAP objectclass for groups.
    Group ID Attribute                 LDAP attribute mapped to group id.
    Group Name Attribute               LDAP attribute mapped to group name.
    Group Member Attribute             LDAP attribute that maps user to group.
    Group description Attribute        LDAP attribute mapped to description.
    List of additional Domains         Blocks of additional domains/parameters that should be created.

    ================================== ===============

#. To deploy an environment with support of multiple domains 'List of additional Domains'
   text area should be used. All needed parameters that describes a domain should be copied there,
   all parameters form a block of paramters.

   .. image:: images/additional_domains.png

   To add multiple domains such block of parameters should be added
   to 'List of additional Domains' text area and these blocks should
   be separated by empty line.

#. Continue with environment configuration and deploy it;
   for instructions, see
   `Mirantis OpenStack User Guide <https://docs.mirantis.com/openstack/fuel/fuel-8.0/pdf/Fuel-8.0-UserGuide.pdf>`_.

#. After successfull environment deployment log into dashboard in default domain:

   .. image:: images/default_domain.png

#. Go to Identity -> Domains, select needed domain and 'Set Domain Context' for the domain:

   .. image:: images/domains.png
   .. image:: images/domain_context.png

#. Go to Identity -> Projects and select 'Create Project' to create a new project for the domain
   and add user members to the project:

   .. image:: images/project.png
   .. image:: images/project_members.png
