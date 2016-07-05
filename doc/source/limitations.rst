LDAP plugin limitations
-----------------------

#. LDAP plugin has the following limitations:

   - Installation of LDAP plugin before deployment only;
   - Fuel will not validate the settings, e.g., by attempting to connect to the LDAP server;
   - In multidomain configuration the attributes of the first domain are filled in the web form, 
     whereas the attributes of other domains are filled in one field;
   - The settings of domains determined in “List of additional Domains” field will not be validated;
   - The settings of proxy determined in "List of custom LDAP proxy configs" field will not be validated;
