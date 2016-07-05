LDAP plugin validation
----------------------

#. To validate that LDAP plugin is successfully applied after deployment:

   - Log into Horizon using domain/user credentials from LDAP server;
   - Create an instance;

   Expecting results:

   - All LDAP users can authenticate via Keystone;
   - An instance is successfully created;
