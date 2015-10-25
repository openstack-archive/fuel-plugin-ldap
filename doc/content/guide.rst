==========
User Guide
==========

Environment configuration
=========================

1. Create an environment. For more information about environment creation, see
   `Mirantis OpenStack User Guide <http://docs.mirantis.com/openstack/fuel
   /fuel-7.0/user-guide.html#create-a-new-openstack-environment>`_.
2. Enable and configure LDAP plugin for Fuel. For instructions, see LDAP
   Plugin Guide in the `Fuel Plugins Catalog <https://www.mirantis.com
   /products/openstack-drivers-and-plugins/fuel-plugins/>`_.
3. Open *Settings* tab of the Fuel web UI and scroll the page down. On the left
   choose *LDAP plugin for Keystone*, select the plugin checkbox and
   set the following parameters:

   *LDAP domain*
   *LDAP URL*
   *LDAP Suffix*
   *LDAP User*
   *LDAP User Password*
   *Users Tree DN*
   *User Filter*
   *User Object Class*
   *User ID Attribute*
   *User Name Attribute*
   *User Password Attribute*
   *ser Enabled/Disabled Attribute*
   
   .. image:: images/settings.png
      :width: 50%

4. Adjust other environment settings to your requirements and deploy the
   environment. For more information, see
   `Mirantis OpenStack User Guide <http://docs.mirantis.com/openstack/fuel
   /fuel-7.0/user-guide.html#create-a-new-openstack-environment>`_.

5. After a successful deployment, it can be possible to use all users
  created on ldap server for authentication. To test it login to horizon
  dashboard can be performed:

   .. image:: images/dashboard.png
       :width: 50%

   or i.e. a token can be obtained after succefull authentication:

   curl -i -s      -H "Content-Type: application/json"      -d '
      { "auth": {
          "identity": {
            "methods": ["password"],
            "password": {
              "user": {
                "name": "admin",
                "domain": { "id": "default" },
                "password": "admin"
              }
            }
          },
          "scope": {
            "project": {
              "name": "admin",
              "domain": { "id": "default" }
            }
          }
        }
      }'      http://172.16.57.82:5000/v3/auth/tokens
   HTTP/1.1 201 Created
   X-Subject-Token: 77a7c2da81f54bb7b46efefa7c7bb5ae
   Vary: X-Auth-Token
   Content-Type: application/json
   Content-Length: 2173

