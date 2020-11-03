# =================================================================================================
# SCRIPT: RECONCILIATION TEST TLINKWH
#
# Purpose:
#   Set up the reconciler engine so that it can be used to verify data load
#   of martLegacyTLINK from the TLINK Warehouse.
#
# Description:
#   Inserts a number of sql statements into the reconciliation tester so that
#   it can run reconciliation tests.
#
# Release History:
#   Date     Who Changes
#   -------- --- ----------------------------------------------------------------------------------
#   02.07.17 NS  Version 1.0
#   28.07.17 TW  Change SQL_A '...martLegacyTLINKWH...' to '...martLegacyTLINK...'
#                Change SOURCE_A_NAME 'AURORA_DEV' to 'AURORA_TEST'
#                Add tests for table T_TL_W_AGENCY
#                Amend syntax of date related WHERE clauses
#   03.08.17 TW  Tested the tests for rule 1, correct typos, etc.
#   04.08.17 TW  Tested the tests for rules 2 to 4, correct typos, etc.
#   09.08.17 TW  TL_W_ACCOMROUTE add 'WHERE AMENDMENT_ORDER = 0'
#    
# =================================================================================================

# -------------------------------------------------------------------------------------------------
# RULES TO VERIFY / RECONCILE TABLES
# Four rules per table:
#    1 - row counts agree, base verify tables are of equal length
#    2 - null counts in a column agree, check nulls are transposed correctly
#    3 - row count based on records in a date range agree, checks date conversion
#    4 - if numeric column exists, test checksum of a column
# -------------------------------------------------------------------------------------------------

SET SQL_SAFE_UPDATES = 0;
DELETE FROM logs.RECON_TEST_RULES
WHERE TEST_GROUP = 'TLINK WH reconciles with martLegacyTLINK';

# VERIFY ROW COUNTS -------------------------------------------------------------------------------

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGCOSTS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGCOSTS',
     'select count(*) as RESULT from TL_W_BOOKINGCOSTS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGPRICES table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGPRICES',
     'select count(*) as RESULT from TL_W_BOOKINGPRICES');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDEXTRAS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDEXTRAS',
     'select count(*) as RESULT from TL_W_BOOKEDEXTRAS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_HSPLIT table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_HSPLIT',
     'select count(*) as RESULT from CMS_W_HSPLIT');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_FLIGHTCONTRACTS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_FLIGHTCONTRACTS',
     'select count(*) as RESULT from TL_W_FLIGHTCONTRACTS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDFLIGHTS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDFLIGHTS',
     'select count(*) as RESULT from TL_W_BOOKEDFLIGHTS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_ACCOMROUTE table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_ACCOMROUTE',
     'select count(*) as RESULT from TL_W_ACCOMROUTE WHERE AMENDMENT_ORDER = 0');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDACCOMMODATION table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDACCOMMODATION',
     'select count(*) as RESULT from TL_W_BOOKEDACCOMMODATION');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDTRANSFERS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDTRANSFERS',
     'select count(*) as RESULT from TL_W_BOOKEDTRANSFERS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGCOMMENTS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGCOMMENTS',
     'select count(*) as RESULT from TL_W_BOOKINGCOMMENTS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DAGENT table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_DAGENT',
     'select count(*) as RESULT from CMS_W_DAGENT');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGS',
     'select count(*) as RESULT from TL_W_BOOKINGS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS_DIM_DATA table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGS_DIM_DATA',
     'select count(*) as RESULT from TL_W_BOOKINGS_DIM_DATA');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_PASSENGERS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_PASSENGERS',
     'select count(*) as RESULT from TL_W_PASSENGERS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS_TOMS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGS_TOMS',
     'select count(*) as RESULT from TL_W_BOOKINGS_TOMS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DSPLIT table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_DSPLIT',
     'select count(*) as RESULT from CMS_W_DSPLIT');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DVDN table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_DVDN',
     'select count(*) as RESULT from CMS_W_DVDN');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDCARHIRE table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDCARHIRE',
     'select count(*) as RESULT from TL_W_BOOKEDCARHIRE');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AGENCY table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_AGENCY',
     'select count(*) as RESULT from TL_W_AGENCY');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'T_TL_W_AGENCY table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.T_TL_W_AGENCY',
     'select count(*) as RESULT from T_TL_W_AGENCY');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_ACCOM_UNITS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_ACCOM_UNITS',
     'select count(*) as RESULT from TL_W_ACCOM_UNITS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_RESORTREGIONCOUNTRYVIEW table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_RESORTREGIONCOUNTRYVIEW',
     'select count(*) as RESULT from TL_W_RESORTREGIONCOUNTRYVIEW');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'SPECIALIST_FORECAST table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.SPECIALIST_FORECAST',
     'select count(*) as RESULT from SPECIALIST_FORECAST');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TLINK_DAYDIMENSION table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TLINK_DAYDIMENSION',
     'select count(*) as RESULT from TLINK_DAYDIMENSION');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'GATEWAY_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.GATEWAY_DIM',
     'select count(*) as RESULT from GATEWAY_DIM');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'FLIGHT_CLASS_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.FLIGHT_CLASS_DIM',
     'select count(*) as RESULT from FLIGHT_CLASS_DIM');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_VDN table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_VDN',
     'select count(*) as RESULT from RESP_DT_VDN');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_HOLDBACKS_NEW table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_HOLDBACKS_NEW',
     'select count(*) as RESULT from TL_W_HOLDBACKS_NEW');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AIRPORTS table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_AIRPORTS',
     'select count(*) as RESULT from TL_W_AIRPORTS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_SKILLX table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_SKILLX',
     'select count(*) as RESULT from RESP_DT_SKILLX');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'DIFFERENTIATED_ACCOM table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.DIFFERENTIATED_ACCOM',
     'select count(*) as RESULT from DIFFERENTIATED_ACCOM');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'BRANCH_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.BRANCH_DIM',
     'select count(*) as RESULT from BRANCH_DIM');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_AGENT table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_AGENT',
     'select count(*) as RESULT from RESP_DT_AGENT');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_SKILL table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_SKILL',
     'select count(*) as RESULT from RESP_DT_SKILL');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AIRLINES table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_AIRLINES',
     'select count(*) as RESULT from TL_W_AIRLINES');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'PRIMARY_COUNTRY_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.PRIMARY_COUNTRY_DIM',
     'select count(*) as RESULT from PRIMARY_COUNTRY_DIM');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'COUNTRY_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.COUNTRY_DIM',
     'select count(*) as RESULT from COUNTRY_DIM');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_CLW table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_CLW',
     'select count(*) as RESULT from RESP_DT_CLW');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'DYNAMICS_EXTRA_TYPE table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.DYNAMICS_EXTRA_TYPE',
     'select count(*) as RESULT from DYNAMICS_EXTRA_TYPE');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'REGION_DIV_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.REGION_DIV_DIM',
     'select count(*) as RESULT from REGION_DIV_DIM');

# VERIFY ROW COUNTS WHERE A COLUMN IS NULL --------------------------------------------------------

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGCOSTS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGCOSTS where CODE is null',
     'select count(*) as RESULT from TL_W_BOOKINGCOSTS where CODE is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGPRICES table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGPRICES where CODE is null',
     'select count(*) as RESULT from TL_W_BOOKINGPRICES where CODE is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDEXTRAS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDEXTRAS where NOTE is null',
     'select count(*) as RESULT from TL_W_BOOKEDEXTRAS where NOTE is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_HSPLIT table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_HSPLIT where PERIOD9 is null',
     'select count(*) as RESULT from CMS_W_HSPLIT where PERIOD9 is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_FLIGHTCONTRACTS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_FLIGHTCONTRACTS where GDS_SOURCE is null',
     'select count(*) as RESULT from TL_W_FLIGHTCONTRACTS where GDS_SOURCE is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDFLIGHTS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDFLIGHTS where TERMINAL is null',
     'select count(*) as RESULT from TL_W_BOOKEDFLIGHTS where TERMINAL is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_ACCOMROUTE table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_ACCOMROUTE where RESORT_ROUTE is null',
     'select count(*) as RESULT from TL_W_ACCOMROUTE where RESORT_ROUTE is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDACCOMMODATION table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDACCOMMODATION where ACCOM_COMMENT is null',
     'select count(*) as RESULT from TL_W_BOOKEDACCOMMODATION where ACCOM_COMMENT is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDTRANSFERS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDTRANSFERS where NOTE is null',
     'select count(*) as RESULT from TL_W_BOOKEDTRANSFERS where NOTE is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGCOMMENTS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGCOMMENTS where COMMENT_TEXT is null',
     'select count(*) as RESULT from TL_W_BOOKINGCOMMENTS where COMMENT_TEXT is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DAGENT table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_DAGENT where EVENT_9 is null',
     'select count(*) as RESULT from CMS_W_DAGENT where EVENT_9 is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGS where CANCELLATION_DATE is null',
     'select count(*) as RESULT from TL_W_BOOKINGS where CANCELLATION_DATE is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS_DIM_DATA table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGS_DIM_DATA where TURNAROUND_COUNTRY is null',
     'select count(*) as RESULT from TL_W_BOOKINGS_DIM_DATA where TURNAROUND_COUNTRY is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_PASSENGERS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_PASSENGERS where DOB is null',
     'select count(*) as RESULT from TL_W_PASSENGERS where DOB is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS_TOMS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGS_TOMS where AMENDMENT_DATE is null',
     'select count(*) as RESULT from TL_W_BOOKINGS_TOMS where AMENDMENT_DATE is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DSPLIT table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_DSPLIT where ASSISTS is null',
     'select count(*) as RESULT from CMS_W_DSPLIT where ASSISTS is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DVDN table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_DVDN where ANSCONN_CALLS10 is null',
     'select count(*) as RESULT from CMS_W_DVDN where ANSCONN_CALLS10 is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDCARHIRE table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDCARHIRE where CAR_HIRE_COMMENT is null',
     'select count(*) as RESULT from TL_W_BOOKEDCARHIRE where CAR_HIRE_COMMENT is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AGENCY table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_AGENCY where COMMISSION_GROUP is null',
     'select count(*) as RESULT from TL_W_AGENCY where COMMISSION_GROUP is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'T_TL_W_AGENCY table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.T_TL_W_AGENCY where COMMISSION_GROUP is null',
     'select count(*) as RESULT from T_TL_W_AGENCY where COMMISSION_GROUP is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_ACCOM_UNITS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_ACCOM_UNITS where AMENDMENT_DATE is null',
     'select count(*) as RESULT from TL_W_ACCOM_UNITS where AMENDMENT_DATE is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_RESORTREGIONCOUNTRYVIEW table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_RESORTREGIONCOUNTRYVIEW where CONTINENT is null',
     'select count(*) as RESULT from TL_W_RESORTREGIONCOUNTRYVIEW where CONTINENT is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'SPECIALIST_FORECAST table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.SPECIALIST_FORECAST where WEB_PAX_FORECAST is null',
     'select count(*) as RESULT from SPECIALIST_FORECAST where WEB_PAX_FORECAST is null');

    # TLINK_DAYDIMENSION has no null fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'GATEWAY_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.GATEWAY_DIM where GATEWAY_NAME is null',
     'select count(*) as RESULT from GATEWAY_DIM where GATEWAY_NAME is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'FLIGHT_CLASS_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.FLIGHT_CLASS_DIM where FLIGHT_CLASS_DESCRIPTION is null',
     'select count(*) as RESULT from FLIGHT_CLASS_DIM where FLIGHT_CLASS_DESCRIPTION is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_VDN table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_VDN where VDN_DESCRIPTION is null',
     'select count(*) as RESULT from RESP_DT_VDN where VDN_DESCRIPTION is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_HOLDBACKS_NEW table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_HOLDBACKS_NEW where CURRENCY is null',
     'select count(*) as RESULT from TL_W_HOLDBACKS_NEW where CURRENCY is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AIRPORTS table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_AIRPORTS where TEL3 is null',
     'select count(*) as RESULT from TL_W_AIRPORTS where TEL3 is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_SKILLX table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_SKILLX where PCA_REPORTING_DESC is null',
     'select count(*) as RESULT from RESP_DT_SKILLX where PCA_REPORTING_DESC is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'DIFFERENTIATED_ACCOM table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.DIFFERENTIATED_ACCOM where CLASSIFICATION is null',
     'select count(*) as RESULT from DIFFERENTIATED_ACCOM where CLASSIFICATION is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'BRANCH_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.BRANCH_DIM where POSTCODE is null',
     'select count(*) as RESULT from BRANCH_DIM where POSTCODE is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_AGENT table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_AGENT where ALTRESSYSTEMLOGIN is null',
     'select count(*) as RESULT from RESP_DT_AGENT where ALTRESSYSTEMLOGIN is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_SKILL table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_SKILL where PCA_REPORTING_DESC is null',
     'select count(*) as RESULT from RESP_DT_SKILL where PCA_REPORTING_DESC is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AIRLINES table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_AIRLINES where AGENT_COMMISION is null',
     'select count(*) as RESULT from TL_W_AIRLINES where AGENT_COMMISION is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'PRIMARY_COUNTRY_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.PRIMARY_COUNTRY_DIM where ALT_PRIMARY_COUNTRY is null',
     'select count(*) as RESULT from PRIMARY_COUNTRY_DIM where ALT_PRIMARY_COUNTRY is null');

    # COUNTRY_DIM does not have available nullable columns

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_CLW table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_CLW where ALTRESSYSTEMLOGIN is null',
     'select count(*) as RESULT from RESP_DT_CLW where ALTRESSYSTEMLOGIN is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'DYNAMICS_EXTRA_TYPE table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.DYNAMICS_EXTRA_TYPE where TL_EXTRA_GROUP is null',
     'select count(*) as RESULT from DYNAMICS_EXTRA_TYPE where TL_EXTRA_GROUP is null');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'REGION_DIV_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK where a given column is null.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.REGION_DIV_DIM where DIVISIONAL_EMAIL is null',
     'select count(*) as RESULT from REGION_DIV_DIM where DIVISIONAL_EMAIL is null');

# VERIFY BOOKING COUNT BY DATE WHERE THERE ARE VALID CANDIDATE DATE FIELDS IN THE TABLE -----------

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGCOSTS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGCOSTS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_BOOKINGCOSTS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
    'TL_W_BOOKINGPRICES table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
    'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
    'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGPRICES where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
    'select count(*) as RESULT from TL_W_BOOKINGPRICES where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDEXTRAS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDEXTRAS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_BOOKEDEXTRAS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_HSPLIT table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_HSPLIT where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from CMS_W_HSPLIT where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_FLIGHTCONTRACTS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_FLIGHTCONTRACTS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_FLIGHTCONTRACTS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDFLIGHTS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDFLIGHTS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_BOOKEDFLIGHTS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_ACCOMROUTE table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_ACCOMROUTE where AMENDMENT_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_ACCOMROUTE where AMENDMENT_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\') AND AMENDMENT_ORDER = 0');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDACCOMMODATION table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDACCOMMODATION where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_BOOKEDACCOMMODATION where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDTRANSFERS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDTRANSFERS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_BOOKEDTRANSFERS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGCOMMENTS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGCOMMENTS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_BOOKINGCOMMENTS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DAGENT table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_DAGENT where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from CMS_W_DAGENT where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_BOOKINGS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS_DIM_DATA table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGS_DIM_DATA where BOOKING_VERSION_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_BOOKINGS_DIM_DATA where BOOKING_VERSION_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_PASSENGERS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_PASSENGERS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_PASSENGERS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS_TOMS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKINGS_TOMS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_BOOKINGS_TOMS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DSPLIT table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_DSPLIT where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from CMS_W_DSPLIT where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DVDN table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.CMS_W_DVDN where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from CMS_W_DVDN where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDCARHIRE table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_BOOKEDCARHIRE where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_BOOKEDCARHIRE where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AGENCY table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_AGENCY where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_AGENCY where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'T_TL_W_AGENCY table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.T_TL_W_AGENCY where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from T_TL_W_AGENCY where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_ACCOM_UNITS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_ACCOM_UNITS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_ACCOM_UNITS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_RESORTREGIONCOUNTRYVIEW table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_RESORTREGIONCOUNTRYVIEW where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_RESORTREGIONCOUNTRYVIEW where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'SPECIALIST_FORECAST table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.SPECIALIST_FORECAST where AMENDMENT_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from SPECIALIST_FORECAST where AMENDMENT_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TLINK_DAYDIMENSION table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TLINK_DAYDIMENSION where DAY_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TLINK_DAYDIMENSION where DAY_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    # nothing for GATEWAY_DIM, no date fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'FLIGHT_CLASS_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.FLIGHT_CLASS_DIM where AMENDED_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from FLIGHT_CLASS_DIM where AMENDED_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    # nothing for RESP_DT_VDN no date fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_HOLDBACKS_NEW table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_HOLDBACKS_NEW where ADDED_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_HOLDBACKS_NEW where ADDED_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AIRPORTS table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_AIRPORTS where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_AIRPORTS where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_SKILLX table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_SKILLX where AMENDMENT_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from RESP_DT_SKILLX where AMENDMENT_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    # nothing for DIFFERENTIATED_ACCOM no date fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'BRANCH_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.BRANCH_DIM where AMENDED_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from BRANCH_DIM where AMENDED_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_AGENT table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_AGENT where ONSALEDATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from RESP_DT_AGENT where ONSALEDATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_SKILL table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_SKILL where AMENDMENT_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from RESP_DT_SKILL where AMENDMENT_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AIRLINES table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.TL_W_AIRLINES where PROCESS_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from TL_W_AIRLINES where PROCESS_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    # nothing for PRIMARY_COUNTRY_DIM no date fields

    # nothing for COUNTRY_DIM no date fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_CLW table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.RESP_DT_CLW where ONSALEDATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from RESP_DT_CLW where ONSALEDATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

    # nothing for DYNAMICS_EXTRA_TYPE no date fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'REGION_DIV_DIM table should have same number of rows in the TLINK WH and martLegacyTLINK for this year filtered on a date field.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select count(*) as RESULT from martLegacyTLINK.REGION_DIV_DIM where AMENDED_DATE >= str_to_date(\'2017-01-01 00:00:00\', \'%Y-%m-%d %H:%i:%s\')',
     'select count(*) as RESULT from REGION_DIV_DIM where AMENDED_DATE >= TO_DATE(\'2017-01-01 00:00:00\', \'YYYY-MM-DD hh24:mi:ss\')');

# VERIFY CHECKSUM OF NUMERIC COLUMNS --------------------------------------------------------------

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGCOSTS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(BOOKING_COST) as RESULT from martLegacyTLINK.TL_W_BOOKINGCOSTS',
     'select sum(BOOKING_COST) as RESULT from TL_W_BOOKINGCOSTS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGPRICES table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(ADULT_PRICE) as RESULT from martLegacyTLINK.TL_W_BOOKINGPRICES',
     'select sum(ADULT_PRICE) as RESULT from TL_W_BOOKINGPRICES');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDEXTRAS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(PRICE) as RESULT from martLegacyTLINK.TL_W_BOOKEDEXTRAS',
     'select sum(PRICE) as RESULT from TL_W_BOOKEDEXTRAS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_HSPLIT table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(EVENT1) as RESULT from martLegacyTLINK.CMS_W_HSPLIT',
     'select sum(EVENT1) as RESULT from CMS_W_HSPLIT');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_FLIGHTCONTRACTS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(ADULT_COST) as RESULT from martLegacyTLINK.TL_W_FLIGHTCONTRACTS',
     'select sum(ADULT_COST) as RESULT from TL_W_FLIGHTCONTRACTS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDFLIGHTS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(SEATS) as RESULT from martLegacyTLINK.TL_W_BOOKEDFLIGHTS',
     'select sum(SEATS) as RESULT from TL_W_BOOKEDFLIGHTS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_ACCOMROUTE table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(AMENDMENT_ORDER) as RESULT from martLegacyTLINK.TL_W_ACCOMROUTE',
     'select sum(AMENDMENT_ORDER) as RESULT from TL_W_ACCOMROUTE WHERE AMENDMENT_ORDER = 0');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDACCOMMODATION table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(ROOMS) as RESULT from martLegacyTLINK.TL_W_BOOKEDACCOMMODATION',
     'select sum(ROOMS) as RESULT from TL_W_BOOKEDACCOMMODATION');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDTRANSFERS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(ADULTS) as RESULT from martLegacyTLINK.TL_W_BOOKEDTRANSFERS',
     'select sum(ADULTS) as RESULT from TL_W_BOOKEDTRANSFERS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGCOMMENTS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(DISPLAY_ON_INVOICE) as RESULT from martLegacyTLINK.TL_W_BOOKINGCOMMENTS',
     'select sum(DISPLAY_ON_INVOICE) as RESULT from TL_W_BOOKINGCOMMENTS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DAGENT table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(EVENT_1) as RESULT from martLegacyTLINK.CMS_W_DAGENT',
     'select sum(EVENT_1) as RESULT from CMS_W_DAGENT');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(TOTAL_REVENUE) as RESULT from martLegacyTLINK.TL_W_BOOKINGS',
     'select sum(TOTAL_REVENUE) as RESULT from TL_W_BOOKINGS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS_DIM_DATA table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(DURATION) as RESULT from martLegacyTLINK.TL_W_BOOKINGS_DIM_DATA',
     'select sum(DURATION) as RESULT from TL_W_BOOKINGS_DIM_DATA');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_PASSENGERS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(PRICE) as RESULT from martLegacyTLINK.TL_W_PASSENGERS',
     'select sum(PRICE) as RESULT from TL_W_PASSENGERS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKINGS_TOMS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(TOTAL_COSTS) as RESULT from martLegacyTLINK.TL_W_BOOKINGS_TOMS',
     'select sum(TOTAL_COSTS) as RESULT from TL_W_BOOKINGS_TOMS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DSPLIT table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(EVENT_1) as RESULT from martLegacyTLINK.CMS_W_DSPLIT',
     'select sum(EVENT_1) as RESULT from CMS_W_DSPLIT');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'CMS_W_DVDN table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(SKILL1) as RESULT from martLegacyTLINK.CMS_W_DVDN',
     'select sum(SKILL1) as RESULT from CMS_W_DVDN');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_BOOKEDCARHIRE table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(PRICE) as RESULT from martLegacyTLINK.TL_W_BOOKEDCARHIRE',
     'select sum(PRICE) as RESULT from TL_W_BOOKEDCARHIRE');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AGENCY table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(AMENDMENT_ORDER) as RESULT from martLegacyTLINK.TL_W_AGENCY',
     'select sum(AMENDMENT_ORDER) as RESULT from TL_W_AGENCY');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'T_TL_W_AGENCY table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(AMENDMENT_ORDER) as RESULT from martLegacyTLINK.T_TL_W_AGENCY',
     'select sum(AMENDMENT_ORDER) as RESULT from T_TL_W_AGENCY');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_ACCOM_UNITS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(LOADED) as RESULT from martLegacyTLINK.TL_W_ACCOM_UNITS',
     'select sum(LOADED) as RESULT from TL_W_ACCOM_UNITS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_RESORTREGIONCOUNTRYVIEW table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(AMENDMENT_ORDER) as RESULT from martLegacyTLINK.TL_W_RESORTREGIONCOUNTRYVIEW',
     'select sum(AMENDMENT_ORDER) as RESULT from TL_W_RESORTREGIONCOUNTRYVIEW');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'SPECIALIST_FORECAST table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(CC_PAX_PERC) as RESULT from martLegacyTLINK.SPECIALIST_FORECAST',
     'select sum(CC_PAX_PERC) as RESULT from SPECIALIST_FORECAST');

    # TLINK_DAYDIMENSION has no null fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'GATEWAY_DIM table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(SK_COUNTRY_ID) as RESULT from martLegacyTLINK.GATEWAY_DIM',
     'select sum(SK_COUNTRY_ID) as RESULT from GATEWAY_DIM');

    # FLIGHT_CLASS_DIM has no numeric fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_VDN table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(VECTOR) as RESULT from martLegacyTLINK.RESP_DT_VDN',
     'select sum(VECTOR) as RESULT from RESP_DT_VDN');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_HOLDBACKS_NEW table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(HOLD_BACK_AMOUNT) as RESULT from martLegacyTLINK.TL_W_HOLDBACKS_NEW',
     'select sum(HOLD_BACK_AMOUNT) as RESULT from TL_W_HOLDBACKS_NEW');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AIRPORTS table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(SLIP_DAYS) as RESULT from martLegacyTLINK.TL_W_AIRPORTS',
     'select sum(SLIP_DAYS) as RESULT from TL_W_AIRPORTS');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_SKILLX table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(SKILL_NUMBER) as RESULT from martLegacyTLINK.RESP_DT_SKILLX',
     'select sum(SKILL_NUMBER) as RESULT from RESP_DT_SKILLX');

    # DIFFERENTIATED_ACCOM has no numeric fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'BRANCH_DIM table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(SHOP_NUM) as RESULT from martLegacyTLINK.BRANCH_DIM',
     'select sum(SHOP_NUM) as RESULT from BRANCH_DIM');

    # RESP_DT_AGENT has no numeric fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'RESP_DT_SKILL table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(SKILL_NUMBER) as RESULT from martLegacyTLINK.RESP_DT_SKILL',
     'select sum(SKILL_NUMBER) as RESULT from RESP_DT_SKILL');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'TL_W_AIRLINES table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(INBOUND_RULE) as RESULT from martLegacyTLINK.TL_W_AIRLINES',
     'select sum(INBOUND_RULE) as RESULT from TL_W_AIRLINES');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'PRIMARY_COUNTRY_DIM table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(SK_COUNTRY_ID) as RESULT from martLegacyTLINK.PRIMARY_COUNTRY_DIM',
     'select sum(SK_COUNTRY_ID) as RESULT from PRIMARY_COUNTRY_DIM');

    # COUNTRY_DIM does not have available nullable columns

    # RESP_DT_CLW has no numeric fields

    # DYNAMICS_EXTRA_TYPE has no numeric fields

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B)
    values
    ('Y', 
     'REGION_DIV_DIM table should have a checksum column total the same in the TLINK WH and martLegacyTLINK.', 
     'TLINK WH reconciles with martLegacyTLINK', 'AURORA_TEST', 'TLINK_WH', 
     'select sum(SK_REGION_ID) as RESULT from martLegacyTLINK.REGION_DIV_DIM',
     'select sum(SK_REGION_ID) as RESULT from REGION_DIV_DIM');
