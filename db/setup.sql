-- noinspection SqlNoDataSourceInspectionForFile

-- DB1
create user 'demouser'@'%' identified WITH caching_sha2_password by 'password';
grant replication slave on *.* to 'demouser'@'%';
FLUSH PRIVILEGES;
show binary log status; -- SAVE THE RESULT OF THIS COMMAND

-- DB2
create user 'demouser'@'%' identified WITH caching_sha2_password by 'password';
grant replication slave on *.* to 'demouser'@'%';
FLUSH PRIVILEGES;
stop replica;
CHANGE REPLICATION SOURCE TO
       SOURCE_HOST = 'db1',
       SOURCE_USER = 'demouser',
       SOURCE_PASSWORD = 'password',
       SOURCE_SSL = 1,
       SOURCE_SSL_CA = '/etc/mysql/ssl/ca-cert.pem',
       SOURCE_LOG_FILE = 'mysql-bin.000003', -- THIS VALUE IS FROM THE RESULT OF THE COMMAND "show binary log status;" above
       SOURCE_LOG_POS = 882; -- THIS VALUE IS FROM THE RESULT OF THE COMMAND "show binary log status;" above
start replica;
show binary log status; -- SAVE THE RESULT OF THIS COMMAND

-- DB1
stop replica;
CHANGE REPLICATION SOURCE TO
       SOURCE_HOST = 'db2',
       SOURCE_USER = 'demouser',
       SOURCE_PASSWORD = 'password',
       SOURCE_SSL = 1,
       SOURCE_SSL_CA = '/etc/mysql/ssl/ca-cert.pem',
       SOURCE_LOG_FILE = 'mysql-bin.000003', -- THIS VALUE IS FROM THE RESULT OF THE COMMAND "show binary log status;" above
       SOURCE_LOG_POS = 881; -- THIS VALUE IS FROM THE RESULT OF THE COMMAND "show binary log status;" above
start replica;


-- TEST THE REPLICATION
-- DB1
create database demo;
use demo;
create table test (id int);

-- DB2
show databases;
use demo;
show tables;

-- DEBUG
SHOW REPLICA STATUS\G;
