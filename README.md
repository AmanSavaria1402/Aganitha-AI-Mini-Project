
# Aganitha-AI-Mini-Project

This repository contains the code and the replication instructions of the mini-project given by [Aganitha](https://aganitha.ai/). The goal/objective of the project was the following:

1. Create a git repo for your project and save code for all steps below in your repo 
2. Setup Postgres in a docker container and import any dataset of your liking into it
3. Setup Jupyter in another docker container
4. Write a notebook using #1, connecting to the Postgres database set up in #2 without hardcoding the latter's IP address, explore the data in the database by executing SQL queries.

This was borrowed from the Coderbyte assignment page.

To visit the notebook yourself, please visit this [link](http://3.17.178.241:8888/?token=677d7d4364783c4c908071f5345b0cfc40663fc4a72a9a8a).

## About the files:

- The **SQL Query.ipynb** is the jupyter notebook that is running in the docker jupyter container in the EC2 instance and is linked to the postgres container via [container legacy links](https://docs.docker.com/network/links/). 
-  The SQL Query.pdf is the pdf file for the same.
- The database.sql is the sql script that is used to construct the postgres database HR that is used in the notebook. The sql script has been taken from [here](https://www.sqltutorial.org/sql-sample-database/).

## Steps to recreate this project:

### Setting up the jupyter and postgres containers
- The whole project is hosted in docker containers hosted on an AWS EC2 instance.
- The docker images used in this project are the [Postgres official image](https://hub.docker.com/_/postgres) and the [Jupyter Minimal Notebook](https://hub.docker.com/r/jupyter/minimal-notebook).
To pull these images in your system/cloud instance, use the following commands:

    `docker pull jupyter/minimal-notebook`  and `docker pull postgres`
- Now, create the postgres container first and import the database. Use the following commands to do this:

    `docker run --name postgres_server -v "$PWD"/:/db/ -e POSTGRES_PASSWORD=password -d postgres`<br>
    `docker exec -it postgres_server psql -U postgres -f /db/database.sql`
    <br>**Note:** Change the location in the -v tag to point to the location where the database sql script is stored in the first line.
- Now, create the jupyter notebook container and link it to the postgres container using the following command in the terminal:<br>
`docker run -p 8888:8888 --name jupyter_container --link postgres_server jupyter/minimal-notebook`
- This will start the jupyter notebook/container and will give a of the format `http://0.0.0.0:8888/?token=...`, replace the 0.0.0.0 in the link to the public IP address of the ec2 instance and paste the resulting link in the browser. The jupyter notebook will start.

### Linking the jupyter notebook to the database in the postgres container.

You will need the following libraries:

 - **Pandas:** for executing sql queries and getting results.
 - **Psycopg2, pgspecial and sqlalchemy:** For connecting the jupyter notebook to the database in the postgres container.
The libraries can be installed by the following command:
	`conda install pandas psycopg2 pgspecial ipython-sql`

Then, please refer to the notebook in the repo or the link given above to see how to connect to and execute sql queries on the postgres database.
