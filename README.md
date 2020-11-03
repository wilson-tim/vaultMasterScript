*BD-7 Vault Master Script*  
  
A suite of scripts that increment the data vault to a new version or build an empty vault in an empty installation of Aurora.  
  
The build scripts are coordinated by the deployMaster.bash script which invokes them in turn. The deployMaster accepts parameters so the deploy environment can be passed in dynamically.  
  
The lower level builder scripts include:  
- create schemas (SQL)  
- create or modify tables and views (Liquibase - for Vault)  
- create stored procedures - to create or drop indexes (SQL - for Vault)  
- rebuild all indexes (SQL - for Vault)  
- implement partitioning (SQL - for Vault)  
- insert meta data to drive the ETL (SQL)  
- insert lookup data, fixed value sets (SQL)  
- insert test criteria for smoke tests and each loaded table (SQL)  
- set up user accounts (SQL)  
  
Last updated 23/08/2017  
