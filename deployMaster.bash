#!/bin/bash
#===============================================================================
#
# Purpose:
#   Script to build the Data Vault and Marts in AURORA
#
# Parameters:
#   - DB_URL - the URL and port to connect to the database
#   - DB_USER - username used to connect to the database
#   - DB_PW - password used to connect to the database
#
# Description:
#   This script coordinates the build of the VAULT and MARTS from one version
#   to the next into the 'working copy' Aurora environment. 
#
#   Version 1.1 - this version builds from empty. 
#
#   It verifies that the target is not 'LIVE' status, if it is it fails.
#
#   It then increments the environment:
#     - inserting schemas if they don't exist
#     - using liquibase to build the table structure for vault and marts
#     - creating index drop and create procedures for vault and marts
#     - resetting indexes by dropping and recreating them  for vault and marts
#     - checking partitions are correctly set up and creating them if not
#     - inserting metadata and lookup data
#     - setting up security profile grant procedures
#     - setting up base set of users
#     - inserting deployment smoke test conditions
#     - inserting data load test conditions
#     - running smoke tests for the deployment
#
# Release History:
#   Date     Who Changes Made
#   -------- --- --------------------------------------------------------------
#   28.04.17 NS  Added new step 9 for reconciliation test data, renamed smoke
#                test procedure to insertSmokeTestCriteria so it better 
#                describes what it does, tightened up the echo text output.
#   31.05.17 TW  New step 8 insertReconTestSources.sql
#   04.08.17 TW  New step 11 insertTLINKWHReconciliationTestCriteria.sql
#
#===============================================================================

echo
echo
echo =====================================================================================
echo >> DEPLOYING DATA VAULT

echo
echo       Deploying version 1.1 ...
echo
echo       ... step 0 of 12 - initialising
DB_URL = "$1"
DB_USER = "$2"
DB_PW = "$3"
# Not in first release
# mysql -h $DB_URL -u $DB_USER -p$DB_PW < verifyEnvironmentStatus.sql || exit_on_error "FAILED - trying to update fixed live environment."

echo       ... step 1 of 12 - creating schemas
mysql -h $DB_URL -u $DB_USER -p$DB_PW < createSchemas.sql

echo       ... step 2 of 12 - building the database schema - metadata
java -jar liquibase/liquibase.jar --classpath=./mysqljdbc.jar --changeLogFile=./vault_master.xml --url=jdbc:mysql://$DB_URL --username=$DB_USER --password=$DB_PW --driver=com.mysql.jdbc.Driver --defaultSchemaName=dv update

echo       ... step 3 of 12 - creating user defined functions and procedures
mysql -h $DB_URL -u $DB_USER -p$DB_PW < createHasIndexFunction.sql
mysql -h $DB_URL -u $DB_USER -p$DB_PW < createIndexProcedures.sql
mysql -h $DB_URL -u $DB_USER -p$DB_PW < dropIndexProcedures.sql

echo       ... step 4 of 12 - creating indexes
mysql -h $DB_URL -u $DB_USER -p$DB_PW < resetIndexes.sql

echo       ... step 5 of 12 - creating partitions
mysql -h $DB_URL -u $DB_USER -p$DB_PW < createPartitions.sql
mysql -h $DB_URL -u $DB_USER -p$DB_PW < callCreatePartitions.sql

echo       ... step 6 of 12 - insert data
mysql -h $DB_URL -u $DB_USER -p$DB_PW < insertMetaData.sql
mysql -h $DB_URL -u $DB_USER -p$DB_PW < insertLookupData.sql

echo       ... step 7 of 12 - set up security
# Not in first release
# mysql -h $DB_URL -u $DB_USER -p$DB_PW < setupSecurity.sql

echo       ... step 8 of 12 - create data sources for smoke tests and reconciliation tests
mysql -h $DB_URL -u $DB_USER -p$DB_PW < insertReconTestSources.sql

echo       ... step 9 of 12 - parameterise smoke tests
mysql -h $DB_URL -u $DB_USER -p$DB_PW < insertSmokeTestCriteria.sql

echo       ... step 10 of 12 - parameterise reconciliation tests for TLINK vault loader
mysql -h $DB_URL -u $DB_USER -p$DB_PW < insertReconciliationTestCriteria.sql

echo       ... step 11 of 12 - parameterise reconciliation tests for TLINK WH replication
mysql -h $DB_URL -u $DB_USER -p$DB_PW < insertTLINKWHReconciliationTestCriteria.sql

echo       ... step 12 of 12 - run tests
# Run Talend reconciler, with the smoke test values just inserted

echo
echo >> INSTALLATION COMPLETE
echo =====================================================================================
echo
echo 
