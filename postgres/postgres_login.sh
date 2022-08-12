  #! /bin/bash

 function login {
     # log in to the running container 
     docker exec -it local-postgres-14 bash
 }

#  function activate{
#     # activate the postgres
#     # psql {POSTGRES_DB} -U {POSTGRES_USER}
#     POSTGRES_DB=postgres
#     POSTGRES_USER=postgres
#     psql -h localhost $postgres -U $postgres
#  }

login
#activate