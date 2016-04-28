
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

   There is an example of a block of the paramters:

   domain=ldap225
   password=1111
   group_id_attribute=cn
   user_filter=
   user_allow_update=False
   group_filter=
   user_allow_delete=False
   group_member_attribute=member
   group_objectclass=groupOfNames
   group_tree_dn=dc=mirantis,dc=tld
   query_scope=sub
   suffix=dc=mirantis,dc=tld
   group_name_attribute=cn
   user_tree_dn=dc=mirantis,dc=tld
   group_desc_attribute=description
   url=ldap://172.18.196.224
   user_allow_create=False
   user_id_attribute=cn
   user_pass_attribute=userPassword
   tls_cacertdir=/etc/ssl/certs
   group_allow_delete=False
   group_allow_create=False
   user=cn=admin,dc=mirantis,dc=tld
   user_enabled_attribute=enabled
   use_tls=True
   user_objectclass=inetOrgPerson
   group_allow_update=False
   user_name_attribute=sn
   ca_chain=-----BEGIN CERTIFICATE-----
   MIIDRzCCAf+gAwIBAgIEVuklzDANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDEwht
   aXJhbnRpczAeFw0xNjAzMTYwOTIyMjBaFw0yNjAzMTQwOTIyMjBaMBMxETAPBgNV
   BAMTCG1pcmFudGlzMIIBUjANBgkqhkiG9w0BAQEFAAOCAT8AMIIBOgKCATEAtvHJ
   m7qJqoTp8XtUNYin1sQQK12bUTCKGo2Qdq8KCVFodnX8trAW7YNpMyyZ/eaKmkAJ
   1Ta/SJl5j6KDJh2v2JwmwVZLYz6hXZraaNEZvaSe/N0a71s6C3io2oVyKPXSePgO
   Agmv5DOYQLyGV8ccVHVQj0s//Q3Q88+KuMykGQO0l2LBo2z6cBrjDEkds+W34YeP
   2ZQ2iFwT1GBcuog4CysFHdi0CYO40JUDNim+UP5EXOP+4f0T1JKbNGP7YnXyxm9d
   /RPbiN8PDcgloa3F4mFKW3kkWMtbfcggM8HkPcNHbLerXYQ3vqUmIKC0PH27x7K9
   Bn0THo8hTalDhMfpjgFfruyvtn0yXMwfAaxXxtvCjz8AiF5dLZlF/QFr/+j81PM6
   R6IKmQpIn/UDWG1SAQIDAQABo0MwQTAPBgNVHRMBAf8EBTADAQH/MA8GA1UdDwEB
   /wQFAwMHBAAwHQYDVR0OBBYEFH5Q4yw2+u170/e1+lZScOZ4WPaJMA0GCSqGSIb3
   DQEBCwUAA4IBMQCRPexLKa5nQV02VbGEr5iRlk9WMD9yJ7ygbKZvKH8QM2d48tnf
   1/1tgqIPwP5HbI1zCLXdVwQgFjaz+fIuGINZ5sqz+AB+av9KXoxVVwTp1b7vo34u
   bfKP42ECzAAmBlqsS/RW2F2697oQlgdy8koeFsMxFL/DHHm/pEK7AZrJUi5ANCgQ
   rpQ5ngdk6UYCcRAet5ccc6pkzewnxixVy4JHcmdHc0CpBGdCzD++QbTIruz8sSq0
   Q7A4gCbJNx/FApqhrCeDS6tRiV81qONwy4GsPzo/6QuDHdKzUBsz19yRmJMiXCBU
   KivmZtsndZ5Ce/1KV9OCjfJZ6MpDE+OCegAsiD1MGeiBU9nKT3g2PpZBMHBP95EK
   smMYTjyC1AGUSMThafp9nllfnRNurZSeU5GK
   -----END CERTIFICATE-----

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
