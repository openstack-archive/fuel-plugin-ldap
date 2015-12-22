==========
User Guide
==========


#. After successfull environment deployment, log into Horizon into the default domain:

   .. image:: images/default_domain.png

#. Go to Identity -> Domains, select the required domain and select
   *Set Domain Context* for it:

   .. image:: images/domains.png
   .. image:: images/domain_context.png

#. Go to Identity -> Projects and select 'Create Project' to create a new project for the domain
   and add user members to the project:

   .. image:: images/project.png
   .. image:: images/project_members.png

#. After successful deployment, all users from the LDAP directory matching the
   configured filter criteria can authenticate against Keystone. To validate the
   configuration, log into the Horizon dashboard using LDAP credentials:

   .. image:: images/dashboard.png

#. You can also try to obtain a token to validate authentication:

   .. code-block:: bash

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

