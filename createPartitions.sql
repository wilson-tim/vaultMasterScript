# =============================================================================
# SCRIPT: CREATE PARTITIONS
#
# Purpose:
#   Ensure that partitions are configured correctly in the VAULT.
#
# Description:
#   Detects if the correct partitions exist. If not, creates them.
#   Detection requires a query against the PARTITIONS table in the INFORMATION
#   schema. We check that only the expected partitions exist (by name). If 
#   we have more partitions than expected, or an expected partition is missing
#   then we need to rebuild the partitions from scratch. Rebuild requires us 
#   to copy and drop the table before applying the partition. To speed things
#   up, we also drop indexes and rebuild after partitioning. Note that a 
#   partition build could take 30 minutes or more to complete.
#
# Release History:
#   Date     Who Changes Made
#   -------- --- --------------------------------------------------------------
#   07.04.17 NS  Version 1.0
#   19.05.17 TW  Converted to stored procedure to make conditional steps possible
#   02.07.17 NS  Added partition on bookings to cater for quotes and bookings
#                stored in the same table but usually transactionally separated,
#                quotes having 10x more data but being updated less frequently.
#   30.07.17 NS  Amended booking partition to reflect new identity_Set column,
#                replacing booking series.
#   11.08.17 TW  Partition names cannot contain hyphens so amended
#                tlink-booking to tlinkbooking and tlink-quote to tlinkquote
#
# =============================================================================

DROP PROCEDURE IF EXISTS dv.CREATE_PARTITIONS;

DELIMITER //

CREATE PROCEDURE dv.CREATE_PARTITIONS ()
BEGIN
# -----------------------------------------------------------------------------
# PARTITION LINK BOOKING PARTY ROLE TABLE
# the link_booking_party table should be partitioned on the party role column
# check that such partitions exist

DECLARE lbpr_has_partitions integer;
DECLARE lbpr_partition_cust integer;
DECLARE lbpr_partition_supp integer;
DECLARE lbpr_partition_pax integer;
DECLARE lbpr_partition_no_other integer;

DECLARE bkg_has_partitions integer;
DECLARE bkg_partition_bkg integer;
DECLARE bkg_partition_quote integer;
DECLARE bkg_partition_no_other integer;

set lbpr_has_partitions = ((select count(*) from INFORMATION_SCHEMA.PARTITIONS
                      where TABLE_SCHEMA = 'dv' and
                      TABLE_NAME = 'LINK_BOOKING_PARTY_ROLE') > 0);

set lbpr_partition_cust = ((select count(*) from INFORMATION_SCHEMA.PARTITIONS 
                      where TABLE_SCHEMA = 'dv' and 
                      TABLE_NAME = 'LINK_BOOKING_PARTY_ROLE' and 
                      PARTITION_NAME = 'customer') > 0);

set lbpr_partition_supp = ((select count(*) from INFORMATION_SCHEMA.PARTITIONS
                      where TABLE_SCHEMA = 'dv' and 
                      TABLE_NAME = 'LINK_BOOKING_PARTY_ROLE' and 
                      PARTITION_NAME = 'supplier') > 0);

set lbpr_partition_pax = ((select count(*) from INFORMATION_SCHEMA.PARTITIONS 
                      where TABLE_SCHEMA = 'dv' and 
                      TABLE_NAME = 'LINK_BOOKING_PARTY_ROLE' and 
                      PARTITION_NAME = 'pax') > 0);

set lbpr_partition_no_other = ((select count(*) from INFORMATION_SCHEMA.PARTITIONS
                          where TABLE_SCHEMA = 'dv' and 
                          TABLE_NAME = 'LINK_BOOKING_PARTY_ROLE' and 
                          PARTITION_NAME not in ('customer', 'supplier', 'pax')) = 0);

# rebuild needed if expected partitions are not there, or additional unexpected
# partitions are present

if not (lbpr_partition_cust and lbpr_partition_supp and lbpr_partition_pax and lbpr_partition_no_other) then
    # drop indexes to speed things up (note - not the PK index, which includes the partition column)
    CALL dv.DROP_INDEX('dv', 'LINK_BOOKING_PARTY_ROLE');

    # if there are partitions present, then remove by copying to temporary, drop and copy back
    if lbpr_has_partitions then
        DROP TABLE IF EXISTS dv.LINK_BOOKING_PARTY_ROLE_COPY;
        CREATE TABLE dv.LINK_BOOKING_PARTY_ROLE_COPY as SELECT * FROM dv.LINK_BOOKING_PARTY_ROLE;
        DROP TABLE dv.LINK_BOOKING_PARTY_ROLE;
        CREATE TABLE dv.LINK_BOOKING_PARTY_ROLE as SELECT * FROM dv.LINK_BOOKING_PARTY_ROLE_COPY;
        DROP TABLE dv.LINK_BOOKING_PARTY_ROLE_COPY;
        ALTER TABLE dv.LINK_BOOKING_PARTY_ROLE ADD PRIMARY KEY (BOOKING_PARTY_ROLE_HASH, PARTY_ROLE);
    end if;

    # create correct partitioning
    ALTER TABLE dv.LINK_BOOKING_PARTY_ROLE
    PARTITION BY LIST COLUMNS(PARTY_ROLE) 
            (
            PARTITION customer VALUES IN ('CUSTOMER'),
            PARTITION supplier VALUES IN ('SUPPLIER'),
            PARTITION pax VALUES IN ('PASSENGER')
            );

    # rebuild indexes
    CALL dv.CREATE_INDEX('dv', 'LINK_BOOKING_PARTY_ROLE');

end if;

# -----------------------------------------------------------------------------
# PARTITION BOOKING TABLE
# the booking table should be partitioned on the sequence number column
# check that such partitions exist

set bkg_has_partitions = ((select count(*) from INFORMATION_SCHEMA.PARTITIONS
                      where TABLE_SCHEMA = 'dv' and
                      TABLE_NAME = 'HUB_BOOKING') > 0);

set bkg_partition_bkg = ((select count(*) from INFORMATION_SCHEMA.PARTITIONS 
                      where TABLE_SCHEMA = 'dv' and 
                      TABLE_NAME = 'HUB_BOOKING' and 
                      PARTITION_NAME = 'tlinkbooking') > 0);

set bkg_partition_quote = ((select count(*) from INFORMATION_SCHEMA.PARTITIONS
                      where TABLE_SCHEMA = 'dv' and 
                      TABLE_NAME = 'HUB_BOOKING' and 
                      PARTITION_NAME = 'tlinkquote') > 0);

set bkg_partition_no_other = ((select count(*) from INFORMATION_SCHEMA.PARTITIONS
                          where TABLE_SCHEMA = 'dv' and 
                          TABLE_NAME = 'HUB_BOOKING' and 
                          PARTITION_NAME not in ('tlinkbooking', 'tlinkquote')) = 0);

# rebuild needed if expected partitions are not there, or additional unexpected
# partitions are present

if not (bkg_partition_bkg and bkg_partition_quote and bkg_partition_no_other) then
    # drop indexes to speed things up (note - not the PK index, which includes the partition column)
    CALL dv.DROP_INDEX('dv', 'HUB_BOOKING');

    # if there are partitions present, then remove by copying to temporary, drop and copy back
    if bkg_has_partitions then
        DROP TABLE IF EXISTS dv.HUB_BOOKING_COPY;
        CREATE TABLE dv.HUB_BOOKING_COPY as SELECT * FROM dv.HUB_BOOKING;
        DROP TABLE dv.HUB_BOOKING;
        CREATE TABLE dv.HUB_BOOKING as SELECT * FROM dv.HUB_BOOKING_COPY;
        DROP TABLE dv.HUB_BOOKING_COPY;
        ALTER TABLE dv.HUB_BOOKING ADD PRIMARY KEY (BOOKING_HASH, IDENTIFIER_SET);
    end if;

    # create correct partitioning
    ALTER TABLE dv.HUB_BOOKING
    PARTITION BY LIST COLUMNS(IDENTIFIER_SET) 
            (
            PARTITION tlinkbooking VALUES IN ('TLINK-BOOKING-CODES'),
            PARTITION tlinkquote VALUES IN ('TLINK-QUOTE-CODES')
            );

    # rebuild indexes
    CALL dv.CREATE_INDEX('dv', 'HUB_BOOKING');

end if;
END //

DELIMITER ;