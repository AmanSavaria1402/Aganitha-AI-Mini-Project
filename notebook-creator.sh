# creating container for the postgres server
cd pg_database/
ls
docker run --name postgres_server -v "$PWD"/:/db/ -e POSTGRES_PASSWORD=password -d postgres
docker exec -it postgres_server psql -U postgres -f /db/database.sql

# creating the jupyter server and linking to the postgres server
docker run -d -p 8888:8888 --name jupyter_container --link postgres_server jupyter/minimal-notebook
