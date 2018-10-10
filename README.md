# README

Only two containers: db(postgres) and web(rails) 

Note: Run bundle install after pulling repo and before running docker-compose up

To start docker containers
* docker-compose up

To stop docker containers
* docker-compose down

Env vars are set under enviornment in docker-compose.yml. They can be set in an .env file if desired.
* Replace environment with:
env_file:
      - .env

PG is running on a non standard port because I have PG running locally, and will cause bind error.
Set in docker-compose PORTS:
 - "5433:5433"
 
No migrations have been run.
 
