-- noinspection SqlNoDataSourceInspectionForFile

-- DB1
create user 'demouser'@'%' identified WITH mysql_native_password by 'password';
grant replication slave on *.* to 'demouser'@'%';
FLUSH PRIVILEGES;
show binary log status; -- SAVE THE RESULT OF THIS COMMAND

-- DB2
create user 'demouser'@'%' identified WITH mysql_native_password by 'password';
grant replication slave on *.* to 'demouser'@'%';
FLUSH PRIVILEGES;
stop replica;
CHANGE REPLICATION SOURCE TO
       SOURCE_HOST = 'db1',
       SOURCE_USER = 'demouser',
       SOURCE_PASSWORD = 'password',
       SOURCE_LOG_FILE = 'mysql-bin.000003', -- THIS VALUE IS FROM THE RESULT OF THE COMMAND "show binary log status;" above
       SOURCE_LOG_POS = 851; -- THIS VALUE IS FROM THE RESULT OF THE COMMAND "show binary log status;" above
start replica;
show binary log status; -- SAVE THE RESULT OF THIS COMMAND

-- DB1
stop replica;
CHANGE REPLICATION SOURCE TO
       SOURCE_HOST = 'db2',
       SOURCE_USER = 'demouser',
       SOURCE_PASSWORD = 'password',
       SOURCE_LOG_FILE = 'mysql-bin.000003', -- THIS VALUE IS FROM THE RESULT OF THE COMMAND "show binary log status;" above
       SOURCE_LOG_POS = 851; -- THIS VALUE IS FROM THE RESULT OF THE COMMAND "show binary log status;" above
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
