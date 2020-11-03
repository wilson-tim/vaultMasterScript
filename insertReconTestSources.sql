# =================================================================================================
# SCRIPT: INSERT DATA SOURCES RECORDS
#
# Purpose:
#   Set up data sources for the reconciler engine so that it can be used to run smoke tests and reconciliation tests.
#
# Description:
#   Inserts data source parameter records into the logs.RECON_TEST_SOURCES table
#
# Release History:
#   Date     Who Changes Made
#   -------- --- ----------------------------------------------------------------------------------
#   31.05.17 TW  Version 1.0
#   28.07.17 TW  New data source TLINK_WH
#    
# =================================================================================================

# -----------------------------------------------------------------------------------------------------------------------------------------
# TRUNCATE EXISTING DATA
# -----------------------------------------------------------------------------------------------------------------------------------------
truncate logs.RECON_TEST_SOURCES;

# -------------------------------------------------------------------------------------------------
# logs.RECON_TEST_SOURCES records

INSERT INTO logs.RECON_TEST_SOURCES (`SOURCE_NAME`,`SOURCE_TYPE`,`HOST`,`DBSCHEMA`,`DBNAME`,`PORT`,`USERNAME`,`PASSWORD`,`ADDITIONAL_JDBC`,`RESOURCE_MANAGER`,`NAMENODE_URI`,`RESOURCE_MANAGER_SCHEDULER_ADDRESS`,`JOB_HISTORY_ADDRESS`)
VALUES
 ('HIVE_TL','HIVE','172.23.41.106',NULL,'tl','10000','hadoop',NULL,NULL,'172.23.41.106:8032','hdfs://172.23.41.106:8020','172.23.41.106:8030','172.23.41.106:10020')
,('MSSQL_TLINK_MIRROR_LIVE','MSSQL','172.23.44.100 (V-AWD-SQL-12)','dbo','Live','1433','bi-hadoop','gCH8iWWNAA6UHhswbrti',NULL,NULL,NULL,NULL,NULL)
,('AURORA_TEST','MYSQL','auroratest.cluster-c2fi4unjxcxr.eu-west-1.rds.amazonaws.com',NULL,'dv','3306','auroratest','auroratest','noDatetimeStringSync=true',NULL,NULL,NULL,NULL)
,('TLINK_WH','ORACLE','10.80.226.148','TLINK','DWL','1521','TLINKW','austere',NULL,NULL,NULL,NULL,NULL);

# -------------------------------------------------------------------------------------------------
