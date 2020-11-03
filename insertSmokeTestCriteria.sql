# =================================================================================================
# SCRIPT: INSERT SMOKE TEST CRITERIA
#
# Purpose:
#   Set up the reconciler engine so that it can be used to run smoke tests.
#
# Description:
#   Inserts a number of sql statements into the reconciliation tester that
#   provide test criteria for deployment smoke tests.
#
# Release History:
#   Date     Who Changes Made
#   -------- --- ----------------------------------------------------------------------------------
#   07.04.17 NS  Version 1.0
#   04.05.17 NS  Amended table structure to match new table schema.
#                Added fresh data for test_group, tags, and 'Y' for check_sql only.
#   19.05.17 TW  Amended to reflect revised logs.RECON_TEST_RULES table structure
#   26.05.17 TW  Added statements to insert logs.RECON_TEST_SOURCES records
#                Changed source MYSQL_PROD_RAW to AURORA_TEST
#                Corrected SQL for rules 8, 22, 23, 26, 29, 30
#   26.05.17 NS  Added tests for schema martReconcile and view RECONCILE_RESULTS
#   31.05.17 TW  Added tests for new indexes
#                Moved logs.RECON_TEST_SOURCES insert statements to new script file insertReconTestSources.sql
#   09.06.17 NS  Added tests for additional indexes added (source, cdc)
#   12.07.17 NS  Added tests for missing indexes and tables (e.g. SAT_BUS_HOLDBACK)
#                Replaced schema martLegacy with martLegacyTLINK
#                Added BOOKING_CONVERTS, SAT_EFFECTIVITY_BOOKING_CONVERTS and PARTY_LEAD tables and associated index tests
#                Added HUB_BOOKING TLINK-BOOKING, TLINK-QUOTE partition tests
#                Remove RUN_SEQUENCE column
#   20.07.17 NS  Amended Sat effectivity names, sat_eff._party dropped
#   30.07.17 NS  Amended some effectivity table and index names to align with the data model
#   21.08.17 TW  Added tests for SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS indexes
#   19.08.17 NS  Added RELEASE 1.002 elements, AGENCY Table
#    
# =================================================================================================

SET SQL_SAFE_UPDATES = 0;
DELETE FROM logs.RECON_TEST_RULES
WHERE TEST_GROUP = 'SCHEMA SMOKE TEST';

#============ RELEASE 1.001 - TLINK BOOKING TABLE =================================================
# -------------------------------------------------------------------------------------------------
# RULES TO CHECK SCHEMAS WERE CREATED
insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify schema DV exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.SCHEMATA where SCHEMA_NAME = \'dv\' ',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify schema STG exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.SCHEMATA where SCHEMA_NAME = \'stg\' ',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify schema LOGS exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.SCHEMATA where SCHEMA_NAME = \'logs\' ',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify schema CTRL exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.SCHEMATA where SCHEMA_NAME = \'ctrl\' ',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify schema META exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.SCHEMATA where SCHEMA_NAME = \'meta\' ',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify schema METRICS exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.SCHEMATA where SCHEMA_NAME = \'metrics\' ',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify schema MART KPI exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.SCHEMATA where SCHEMA_NAME = \'martKPI\' ',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify schema MART RECONCILE exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.SCHEMATA where SCHEMA_NAME = \'martReconcile\' ',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify schema MART Legacy TLINK exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.SCHEMATA where SCHEMA_NAME = \'martLegacyTLINK\' ',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify no other schemas exist other than expected.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.SCHEMATA where 
        SCHEMA_NAME not in (\'information_schema\', \'mysql\', \'performance_schema\', \'tmp\', \'dv\', \'logs\', \'ctrl\', \'meta\', \'metrics\', \'martKPI\', \'martReconcile\', \'martLegacyTLINK\', \'stg\')',
        'select 0 as RESULT from DUAL', '');

# -------------------------------------------------------------------------------------------------
# RULES TO CHECK ALL TABLES AND VIEWS WERE CREATED

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify hub booking table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'HUB_BOOKING\'',
        'select 1 as RESULT from DUAL', '');
        
insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat booking details table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_DETAILS\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat booking pax table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_PAX\'',
        'select 1 as RESULT from DUAL', '');

        
insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link booking party role table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_BOOKING_PARTY_ROLE\'',
        'select 1 as RESULT from DUAL', '');
        
insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat booking financials exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_FINANCIALS\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify hub party table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'HUB_PARTY\'',
        'select 1 as RESULT from DUAL', '');

        
insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link booking converts table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_BOOKING_CONVERTS\'',
        'select 1 as RESULT from DUAL', '');


insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking booking converts effectivity table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY\'',
        'select 1 as RESULT from DUAL', '');


insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking booking effectivity table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_EFFECTIVITY\'',
        'select 1 as RESULT from DUAL', '');


insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking booking party role effectivity table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking party effectivity table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_PARTY_EFFECTIVITY\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking party role details table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify view RECONCILE_RESULTS exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.VIEWS where TABLE_SCHEMA = \'martReconcile\' and TABLE_NAME = \'RECONCILE_RESULTS\'',
        'select 1 as RESULT from DUAL', '');

# -------------------------------------------------------------------------------------------------
# RULES TO CHECK INDEXING PROCEDURES WERE CREATED

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify drop index procedure exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.ROUTINES where ROUTINE_NAME = \'DROP_INDEX\'',
        'select 1 as RESULT from DUAL', '');
        
insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify create index procedure exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.ROUTINES where ROUTINE_NAME = \'CREATE_INDEX\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify has index procedure exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.ROUTINES where ROUTINE_NAME = \'HAS_INDEX\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify create partitions procedure exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.ROUTINES where ROUTINE_NAME = \'CREATE_PARTITIONS\'',
        'select 1 as RESULT from DUAL', '');

# ------------------------------------------------------------------------------------------------
# RULES TO CHECK INDEXES WERE CREATED

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify hub booking source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'BOOKING_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'HUB_BOOKING\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify hub party source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'PARTY_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'HUB_PARTY\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link booking party role booking party index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'BOOKING_PARTY_ROLE_BOOKING_PARTY_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_BOOKING_PARTY_ROLE\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link booking party party booking source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'BOOKING_PARTY_ROLE_PARTY_BOOKING_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_BOOKING_PARTY_ROLE\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link booking party role source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'BOOKING_PARTY_ROLE_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_BOOKING_PARTY_ROLE\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify booking quote index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'BOOKING_QUOTE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_BOOKING_CONVERTS\'', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify quote booking index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'QUOTE_BOOKING_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_BOOKING_CONVERTS\'', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking details source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_DETAILS_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_DETAILS\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking details cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_DETAILS_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_DETAILS\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking financials source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_FINANCIALS_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_FINANCIALS\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking financials cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_FINANCIALS_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_FINANCIALS\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking pax source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_PAX_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_PAX\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking pax cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_PAX_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_PAX\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify hub booking effectivity source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_BOOKING_EFFECTIVITY_SOURCE_INDEX \' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_EFFECTIVITY\'', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify hub booking effectivity cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_BOOKING_EFFECTIVITY_CDC_INDEX \' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_EFFECTIVITY\'', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify booking party role effectivity source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_PARTY_ROLE_EFFECTIVITY_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY\'', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify booking party role effectivity cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY\'', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify booking converts effectivity source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY\'', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify booking converts effectivity cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY\'', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking party role details source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink booking party role details cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS\' ', 'select 1 as RESULT from DUAL', '');

# -------------------------------------------------------------------------------------------------
# RULES TO CHECK PARTITIONS WERE CREATED

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify partition for customer exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.PARTITIONS where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_BOOKING_PARTY_ROLE\' and PARTITION_NAME = \'customer\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify partition for supplier exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.PARTITIONS where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_BOOKING_PARTY_ROLE\' and PARTITION_NAME = \'supplier\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify partition for passenger exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.PARTITIONS where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_BOOKING_PARTY_ROLE\' and PARTITION_NAME = \'pax\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify partition for booking exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.PARTITIONS where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'HUB_BOOKING\' and PARTITION_NAME = \'tlinkbooking\'',
        'select 1 as RESULT from DUAL', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify partition for quote exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.PARTITIONS where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'HUB_BOOKING\' and PARTITION_NAME = \'tlinkquote\'',
        'select 1 as RESULT from DUAL', '');


insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify no other partitions exist other than expected.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.PARTITIONS where PARTITION_NAME not in (\'supplier\', \'customer\', \'pax\', \'tlinkbooking\', \'tlinkquote\')',
        'select 0 as RESULT from DUAL', '');

#
#
#============ RELEASE 1.002 - TLINK AGENCY TABLE ==================================================
# -------------------------------------------------------------------------------------------------
# RULES TO CHECK ALL TABLES AND VIEWS WERE CREATED

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify hub locator table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'HUB_LOCATOR\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat_tlink_agency_telephone table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_TELEPHONE\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat_tlink_agency_postal_address table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_POSTAL_ADDRESS\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat_tlink_agency_locator_effectivity table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_LOCATOR_EFFECTIVITY\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat_tlink_agency_party_contact_effectivity locator table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link_party_contact table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_PARTY_CONTACT\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat_tlink_agency_party_contact locator table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_CONTACT\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify hub_geographic_area table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'HUB_GEOGRAPHIC_AREA\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat_tlink_agency_geographic_area_effectivity table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_GEOGRAPHIC_AREA_EFFECTIVITY\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link_party_geographic_area table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_PARTY_GEOGRAPHIC_AREA\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat_tlink_agency_party_geographic_area_effectivity table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat_tlink_agency_party_details table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_DETAILS\'',
        'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat_tlink_agency_party_effectivity table exists.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.TABLES where TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_EFFECTIVITY\'',
        'select 1 as RESULT from DUAL', '');


# ------------------------------------------------------------------------------------------------
# RULES TO CHECK INDEXES WERE CREATED    <<<<<<<<<<<<<<<<<<<<<<<<<

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify hub locator source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'LOCATOR_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'HUB_LOCATOR\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify hub geographic area source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'GEOGRAPHIC_AREA_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'HUB_GEOGRAPHIC_AREA\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link party contact (party to contact) index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'PARTY_CONTACT_PARTY_CONTACT_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_PARTY_CONTACT\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link party contact (contact to party) index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'PARTY_CONTACT_CONTACT_PARTY_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_PARTY_CONTACT\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link party contact source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'PARTY_CONTACT_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_PARTY_CONTACT\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link party geographic area (party to geographic area) index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'PARTY_GEOGRAPHIC_AREA_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_PARTY_GEOGRAPHIC_AREA\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link party geographic area (geographic area to party) index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'GEOGRAPHIC_AREA_PARTY_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_PARTY_GEOGRAPHIC_AREA\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify link party geographic area source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'PARTY_GEOGRAPHIC_AREA_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'LINK_PARTY_GEOGRAPHIC_AREA\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency party details cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_PARTY_DETAILS_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_DETAILS\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency party details source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_PARTY_DETAILS_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_DETAILS\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency party effectivity cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_PARTY_EFFECTIVITY_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_EFFECTIVITY\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency party effectivity source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_PARTY_EFFECTIVITY_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_EFFECTIVITY\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency telephone cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_TELEPHONE_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_TELEPHONE\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency telephone source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_TELEPHONE_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_TELEPHONE\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency party contact cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_PARTY_CONTACT_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_CONTACT\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency party contact source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_PARTY_CONTACT_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_CONTACT\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency party geographic area effectivity cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency party geographic area effectivity source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency postal address cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_POSTAL_ADDRESS_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_POSTAL_ADDRESS\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency postal address source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_POSTAL_ADDRESS_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_POSTAL_ADDRESS\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency locator effectivity cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_LOCATOR_EFFECTIVITY_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_LOCATOR_EFFECTIVITY\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency locator effectivity source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_LOCATOR_EFFECTIVITY_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_LOCATOR_EFFECTIVITY\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency party contact effectivity cdc index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY_CDC_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY\' ', 'select 1 as RESULT from DUAL', '');

insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sat tlink agency telephone source index.', 'SCHEMA SMOKE TEST', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from information_schema.STATISTICS where INDEX_NAME = \'TLINK_AGENCY_PARTY_CONTACT_SOURCE_INDEX\' and
        TABLE_SCHEMA = \'dv\' and TABLE_NAME = \'SAT_TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY\' ', 'select 1 as RESULT from DUAL', '');





