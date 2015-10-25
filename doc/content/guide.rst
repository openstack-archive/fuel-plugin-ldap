==========
User Guide
==========

#. After successful deployment, it can be possible to use all users
   created on LDAP server for authentication. To check the configuration, log into Horizon
   dashboard:

   .. image:: images/dashboard.png
      :width: 100%

#. You can also try to obtain after successful authentication::

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

