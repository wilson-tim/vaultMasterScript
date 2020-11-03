# =================================================================================================
# SCRIPT: INSERT RECONCILIATION TEST CRITERIA
#
# Purpose:
#   Set up the reconciler engine so that it can be used to verify data load
#   of the booking table.
#
# Description:
#   Inserts a number of sql statements into the reconciliation tester so that it can run 
#   reconciliation tests.
#
# Note:
#   
#
# Release History:
#   Date     Who Changes
#   -------- --- ----------------------------------------------------------------------------------
#   19.04.17 NS  Version 1.0
#   24.04.17 TW  Amended SQL scripts to make them work against SQL Server and the purple database.
#   04.05.17 NS  Amended table structure to match new table schema.
#                Added fresh data for test_group, tags, and 'Y' for check_sql only.
#   26.05.17 TW  Changed source AURORA_DEV to AURORA_TEST
#                Changed schema name raw to dv
#                Corrected MySQL statements
#   31.05.17 TW  Change max date to 31/12/9999 23:59:59 from 31/12/9999 00:00:00
#   02.07.17 NS  Removed run_sequence as now autoincrement
#   20.07.17 NS  Amended Sat effectivity names, sat_eff._party dropped
#   30.07.17 NS  Amended effectivity sat name to align with standard
#
# =================================================================================================

SET SQL_SAFE_UPDATES = 0;
DELETE FROM logs.RECON_TEST_RULES
WHERE TEST_GROUP = 'TLINK BOOKING TABLE RECONCILIATION';

# -------------------------------------------------------------------------------------------------
# RULES TO VERIFY / RECONCILE BOOKINGS TABLES
# Three rules per condition - counts or sums up to yesterday, for this year up to yesterday, 
# and for last year. Conditions need to exercise HUB_BOOKING, SAT_TLINK_BOOKING _PAX, _DETAILS and 
# _FINANCIALS, plus HUB_PARTY, LINK_BOOKING_PARTY_ROLE and EFFECTIVITY SATS.
# -------------------------------------------------------------------------------------------------


# VERIFY WE HAVE NO ORPHAN SATELLITES -------------------------------------------------------------
# Count of outer joins should be zero.
# -------------------------------------------------------------------------------------------------

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_TLINK_BOOKING_DETAILS should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_TLINK_BOOKING_DETAILS as A
        left outer join HUB_BOOKING as B
          on A.BOOKING_HASH = B.BOOKING_HASH
          where B.BOOKING_HASH is null',
        'select 0 from dual', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_TLINK_BOOKING_FINANCIALS should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_TLINK_BOOKING_FINANCIALS as A
        left outer join HUB_BOOKING as B
          on A.BOOKING_HASH = B.BOOKING_HASH
          where B.BOOKING_HASH is null',
        'select 0 from dual', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_TLINK_BOOKING_PAX should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_TLINK_BOOKING_PAX as A
        left outer join HUB_BOOKING as B
          on A.BOOKING_HASH = B.BOOKING_HASH
          where B.BOOKING_HASH is null',
        'select 0 from dual', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_BOOKING_BOOKING_EFFECTIVITY should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_BOOKING_BOOKING_EFFECTIVITY as A
        left outer join HUB_BOOKING as B
          on A.BOOKING_HASH = B.BOOKING_HASH
          where B.BOOKING_HASH is null',
        'select 0 from dual', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_BOOKING_PARTY_EFFECTIVITY should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_BOOKING_PARTY_EFFECTIVITY as A
        left outer join HUB_PARTY as B
          on A.PARTY_HASH = B.PARTY_HASH
          where B.PARTY_HASH is null',
        'select 0 from dual', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY as A
        left outer join dv.LINK_BOOKING_PARTY_ROLE as B
          on A.BOOKING_PARTY_ROLE_HASH = B.BOOKING_PARTY_ROLE_HASH
          where B.BOOKING_PARTY_ROLE_HASH is null',
        'select 0 from dual', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_BOOKING_BOOKING_CONVERTS_EFFECTIVITY should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_BOOKING_BOOKING_CONVERTS_EFFECTIVITY as A
        left outer join LINK_BOOKING_CONVERTS as B
          on A.BOOKING_CONVERTS_HASH = B.BOOKING_CONVERTS_HASH
          where B.BOOKING_CONVERTS_HASH is null',
        'select 0 from dual', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY as A
        left outer join LINK_BOOKING_CONVERTS as B
          on A.BOOKING_CONVERTS_HASH = B.BOOKING_CONVERTS_HASH
          where B.BOOKING_CONVERTS_HASH is null',
        'select 0 from dual', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_TLINK_BOOKING_BOOKING_EFFECTIVITY should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_TLINK_BOOKING_BOOKING_EFFECTIVITY as A
        left outer join LINK_BOOKING as B
          on A.BOOKING_HASH = B.BOOKING_HASH
          where B.BOOKING_HASH is null',
        'select 0 from dual', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY as A
        left outer join LINK_BOOKING_PARTY_ROLE as B
          on A.BOOKING_PARTY_ROLE_HASH = B.BOOKING_PARTY_ROLE_HASH
          where B.BOOKING_PARTY_ROLE_HASH is null',
        'select 0 from dual', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS should have no orphans.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'AURORA_TEST', 
        'select count(*) as RESULT from dv.SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS as A
        left outer join LINK_BOOKING_PARTY_ROLE as B
          on A.BOOKING_PARTY_ROLE_HASH = B.BOOKING_PARTY_ROLE_HASH
          where B.BOOKING_PARTY_ROLE_HASH is null',
        'select 0 from dual', '');


#
# VERIFY BOOKING COUNT BY STATUS ------------------------------------------------------------------
# look at 2 status values, totals to yesterday, this year, last year
# only count records with sat_effectivity statuses of LIVE as records will otherwise be
# deleted from SQL Server.
# -------------------------------------------------------------------------------------------------

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify confirmed booking rowcount up to yesterday.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'MSSQL_TLINK_MIRROR_LIVE', 

        'select count(*) as RESULT from dv.HUB_BOOKING as A 
            inner join dv.SAT_BOOKING_BOOKING_EFFECTIVITY as B 
                on A.BOOKING_HASH = B.BOOKING_HASH 
                and B.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and B.STATUS = 1 
            inner join dv.SAT_TLINK_BOOKING_DETAILS as C
                on A.BOOKING_HASH = C.BOOKING_HASH 
                and C.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and C.DEPARTURE_DATE <= date_sub(now(), INTERVAL 1 DAY)
                and C.STATUS = \'1\'',

        'select count(*) as RESULT from dbo.bookings where 
            departuredate <= DATEADD(day, -1, GETDATE())
            and STATUS = \'1\'', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify confirmed booking rowcount this year up to yesterday.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'MSSQL_TLINK_MIRROR_LIVE', 

        'select count(*) as RESULT from dv.HUB_BOOKING as A 
            inner join dv.SAT_BOOKING_BOOKING_EFFECTIVITY as B 
                on A.BOOKING_HASH = B.BOOKING_HASH 
                and B.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and B.STATUS = 1 
            inner join dv.SAT_TLINK_BOOKING_DETAILS as C
                on A.BOOKING_HASH = C.BOOKING_HASH 
                and C.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and C.DEPARTURE_DATE <= date_sub(now(), INTERVAL 1 DAY)
                and C.DEPARTURE_DATE >= str_to_date(concat(year(now()), \'-01-01 00:00:00\'), \'%Y-%m-%d %H:%i:%s\')
                and C.STATUS = \'1\'',

        'select count(*) as RESULT from dbo.bookings where 
           departuredate <= DATEADD(day, -1, GETDATE())
           and departuredate >= DATEADD(year, DATEDIFF(year, 0, GETDATE()), 0)
           and STATUS = \'1\'', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify confirmed booking rowcount last year.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'MSSQL_TLINK_MIRROR_LIVE', 

        'select count(*) as RESULT from dv.HUB_BOOKING as A 
            inner join dv.SAT_BOOKING_BOOKING_EFFECTIVITY as B 
                on A.BOOKING_HASH = B.BOOKING_HASH 
                and B.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and B.STATUS = 1 
            inner join dv.SAT_TLINK_BOOKING_DETAILS as C
                on A.BOOKING_HASH = C.BOOKING_HASH 
                and C.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and C.DEPARTURE_DATE <= str_to_date(concat(year(now())-1, \'-12-31 23:59:59\'), \'%Y-%m-%d %H:%i:%s\')
                and C.DEPARTURE_DATE >= str_to_date(concat(year(now())-1, \'-01-01 00:00:00\'), \'%Y-%m-%d %H:%i:%s\')
                and C.STATUS = \'1\'',

        'select count(*) as RESULT from dbo.bookings where 
           departuredate <= DATEADD(day, -1, DATEADD(year, DATEDIFF(year, 0, GETDATE()), 0))
           and departuredate >= DATEADD(year, DATEDIFF(year, 0, GETDATE()) - 1, 0)
           and STATUS = \'1\'', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify cancelled booking rowcount up to yesterday.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'MSSQL_TLINK_MIRROR_LIVE', 

        'select count(*) as RESULT from dv.HUB_BOOKING as A 
            inner join dv.SAT_BOOKING_BOOKING_EFFECTIVITY as B 
                on A.BOOKING_HASH = B.BOOKING_HASH 
                and B.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and B.STATUS = 1 
            inner join dv.SAT_TLINK_BOOKING_DETAILS as C
                on A.BOOKING_HASH = C.BOOKING_HASH 
                and C.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and C.DEPARTURE_DATE <= date_sub(now(), INTERVAL 1 DAY)
                and C.STATUS = \'2\'',

        'select count(*) as RESULT from dbo.bookings where 
            departuredate <= DATEADD(day, -1, GETDATE())
            and STATUS = \'2\'', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify cancelled booking rowcount this year up to yesterday.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'MSSQL_TLINK_MIRROR_LIVE', 

        'select count(*) as RESULT from dv.HUB_BOOKING as A 
            inner join dv.SAT_BOOKING_BOOKING_EFFECTIVITY as B 
                on A.BOOKING_HASH = B.BOOKING_HASH 
                and B.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and B.STATUS = 1 
            inner join dv.SAT_TLINK_BOOKING_DETAILS as C
                on A.BOOKING_HASH = C.BOOKING_HASH 
                and C.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and C.DEPARTURE_DATE <= date_sub(now(), INTERVAL 1 DAY)
                and C.DEPARTURE_DATE >= str_to_date(concat(year(now()), \'-01-01 00:00:00\'), \'%Y-%m-%d %H:%i:%s\')
                and C.STATUS = \'2\'',

        'select count(*) as RESULT from dbo.bookings where 
           departuredate <= DATEADD(day, -1, GETDATE())
           and departuredate >= DATEADD(year, DATEDIFF(year, 0, GETDATE()), 0)
           and STATUS = \'2\'', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify cancelled booking rowcount last year.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'MSSQL_TLINK_MIRROR_LIVE', 

        'select count(*) as RESULT from dv.HUB_BOOKING as A 
            inner join dv.SAT_BOOKING_BOOKING_EFFECTIVITY as B 
                on A.BOOKING_HASH = B.BOOKING_HASH 
                and B.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and B.STATUS = 1 
            inner join dv.SAT_TLINK_BOOKING_DETAILS as C
                on A.BOOKING_HASH = C.BOOKING_HASH 
                and C.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and C.DEPARTURE_DATE <= str_to_date(concat(year(now())-1, \'-12-31 23:59:59\'), \'%Y-%m-%d %H:%i:%s\')
                and C.DEPARTURE_DATE >= str_to_date(concat(year(now())-1, \'-01-01 00:00:00\'), \'%Y-%m-%d %H:%i:%s\')
                and C.STATUS = \'2\'',

        'select count(*) as RESULT from dbo.bookings where 
           departuredate <= DATEADD(day, -1, DATEADD(year, DATEDIFF(year, 0, GETDATE()), 0))
           and departuredate >= DATEADD(year, DATEDIFF(year, 0, GETDATE()) - 1, 0)
           and STATUS = \'2\'', '');

#
# VERIFY ADULT PAX COUNT --------------------------------------------------------------------------
# look at totals to yesterday, this year, last year
# only count records with sat_effectivity statuses of LIVE as records will otherwise be
# deleted from SQL Server.
# -------------------------------------------------------------------------------------------------

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sum of adult pax up to yesterday.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'MSSQL_TLINK_MIRROR_LIVE', 

        'select ifnull(sum(C.ADULTS), 0) as RESULT from dv.HUB_BOOKING as A 
            inner join dv.SAT_BOOKING_BOOKING_EFFECTIVITY as B 
                on A.BOOKING_HASH = B.BOOKING_HASH 
                and B.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and B.STATUS = 1 
            inner join dv.SAT_TLINK_BOOKING_PAX as C
                on C.BOOKING_HASH = A.BOOKING_HASH
                and C.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
            inner join dv.SAT_TLINK_BOOKING_DETAILS as D
                on D.BOOKING_HASH = A.BOOKING_HASH
                and D.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and D.DEPARTURE_DATE <= date_sub(now(), INTERVAL 1 DAY)',

        'select isnull(sum(ADULTS), 0) as RESULT from dbo.bookings where 
           departuredate <= DATEADD(day, -1, GETDATE())', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sum of adult pax this year up to yesterday.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'MSSQL_TLINK_MIRROR_LIVE', 

        'select ifnull(sum(C.ADULTS), 0) as RESULT from dv.HUB_BOOKING as A 
            inner join dv.SAT_BOOKING_BOOKING_EFFECTIVITY as B 
                on A.BOOKING_HASH = B.BOOKING_HASH 
                and B.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and B.STATUS = 1 
            inner join dv.SAT_TLINK_BOOKING_PAX as C
                on C.BOOKING_HASH = A.BOOKING_HASH
                and C.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
            inner join dv.SAT_TLINK_BOOKING_DETAILS as D
                on D.BOOKING_HASH = A.BOOKING_HASH
                and D.DEPARTURE_DATE <= date_sub(now(), INTERVAL 1 DAY)
                and D.DEPARTURE_DATE >= str_to_date(concat(year(now()), \'-01-01 00:00:00\'), \'%Y-%m-%d %H:%i:%s\')
                and D.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')',

        'select isnull(sum(ADULTS), 0) as RESULT from dbo.bookings where 
           departuredate <= DATEADD(day, -1, GETDATE())
           and departuredate >= DATEADD(year, DATEDIFF(year, 0, GETDATE()), 0)', '');

    insert into logs.RECON_TEST_RULES
    (ACTIVE, TEST_NAME, TEST_GROUP, SOURCE_A_NAME, SOURCE_B_NAME, SQL_A, SQL_B, TAGS)
    values
    ('Y', 'Verify sum of adult pax last year.', 'TLINK BOOKING TABLE RECONCILIATION', 'AURORA_TEST', 'MSSQL_TLINK_MIRROR_LIVE', 

        'select ifnull(sum(C.ADULTS), 0) as RESULT from dv.HUB_BOOKING as A 
            inner join dv.SAT_BOOKING_BOOKING_EFFECTIVITY as B 
                on A.BOOKING_HASH = B.BOOKING_HASH 
                and B.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
                and B.STATUS = 1 
            inner join dv.SAT_TLINK_BOOKING_PAX as C
                on C.BOOKING_HASH = A.BOOKING_HASH
            and C.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')
            inner join dv.SAT_TLINK_BOOKING_DETAILS as D
                on D.BOOKING_HASH = A.BOOKING_HASH
                and D.DEPARTURE_DATE <= str_to_date(concat(year(now())-1, \'-12-31 23:59:59\'), \'%Y-%m-%d %H:%i:%s\')
                and D.DEPARTURE_DATE >= str_to_date(concat(year(now())-1, \'-01-01 00:00:00\'), \'%Y-%m-%d %H:%i:%s\')
                and D.EFFECTIVE_TO = str_to_date(\'9999-12-31 23:59:59\', \'%Y-%m-%d %H:%i:%s\')',

        'select isnull(sum(ADULTS), 0) as RESULT from dbo.bookings where 
           departuredate <= DATEADD(day, -1, DATEADD(year, DATEDIFF(year, 0, GETDATE()), 0))
           and departuredate >= DATEADD(year, DATEDIFF(year, 0, GETDATE()) - 1, 0)', '');
