# Multi master replication demo for MySQL 9
## Setup
#### Spin up docker containers
`docker-compose up -d`
#### Connect to the db1 container
`docker exec -it demo-db1 bash`
#### Connect to the MySQL server
`mysql -u root -p"root1"`
#### Connect to the db2 container in second window
`docker exec -it demo-db2 bash`
#### Connect to the MySQL server
`mysql -u root -p"root2"`
#### Follow the instructions in the `db/setup.sql` file to set and test the replication
