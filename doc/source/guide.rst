==========
User Guide
==========

#. After successful deployment, all users from the LDAP directory matching the
   configured filter criteria can authenticate against Keystone. To validate the
   configuration, log into the Horizon dashboard using LDAP credentials:

   .. image:: images/dashboard.png


#. You can also try to obtain a token to validate authentication::

   # curl -i -s -H "Content-Type: application/json" -d '
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
      }' http://<dashboard_ip>:5000/v3/auth/tokens
   
   HTTP/1.1 201 Created
   X-Subject-Token: 77a7c2da81f54bb7b46efefa7c7bb5ae
   Vary: X-Auth-Token
   Content-Type: application/json
   Content-Length: 2173

