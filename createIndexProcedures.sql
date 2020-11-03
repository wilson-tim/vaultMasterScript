# =============================================================================
# SCRIPT: Create Index Procedures
#
# Purpose:
#   Create all the non-primary key indexes for a given table.
#
# Description:
#   To avoid having to hand code all the index create commands for a table 
#   we collect them into a stored procedure  that creates the set of indexes 
#   around a given table.
#
#   We do not create the primary key - only secondary indexes for tuning
#   reasons. Primary keys are declared in the LIQUIBASE files used to define the
#   schema.
#
# Release History:
#   Date     Who Changes Made
#   -------- --- --------------------------------------------------------------
#   14.02.17 NS  Version 1.0
#   18.05.17 TW  Debugged
#   23.05.17 TW  Added dv.SAT_BUS_HOLDBACK indexes
#   30.05.17 TW  Added EFFECTIVE_TO, EFFECTIVE_FROM columns to satellite CDC indexes
#   09.06.17 NS  Added source system indexes, CDC_hash index on satellites
#   02.07.17 NS  Added link_BOOKING_CONVERTS indexes
#   20.07.17 NS  Amended Sat effectivity index names, sat_eff._party index dropped
#   30.07.17 NS  Effectivity satellite indexes CDC were incorrectly phrased
#   21.08.17 TW  Added statements for table SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS
#   18.08.17 NS  Added release 2 materials - AGENCY table indexes.
# =============================================================================

DROP PROCEDURE IF EXISTS dv.CREATE_INDEX;

# ----------------------------------------------
# procedure to create indexes for a given table, one big case statement

DELIMITER //

CREATE PROCEDURE dv.CREATE_INDEX (IN SCHEMANAME VARCHAR(100), IN TABLENAME VARCHAR(100))
BEGIN
DECLARE caseTable VARCHAR(255);
DECLARE msgText VARCHAR(255);
SET caseTable = concat(SCHEMANAME, '.', TABLENAME);
CASE caseTable

--  release 1.001 indexes - booking ---------------------------------------------------------------

    WHEN 'dv.HUB_BOOKING' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'BOOKING_SOURCE_INDEX') THEN
            CREATE INDEX BOOKING_SOURCE_INDEX 
                ON dv.HUB_BOOKING(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.HUB_PARTY' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'PARTY_SOURCE_INDEX') THEN
            CREATE INDEX PARTY_SOURCE_INDEX 
                ON dv.HUB_PARTY(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.LINK_BOOKING_PARTY_ROLE' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'BOOKING_PARTY_ROLE_BOOKING_PARTY_INDEX') THEN
            CREATE INDEX BOOKING_PARTY_ROLE_BOOKING_PARTY_INDEX 
                ON dv.LINK_BOOKING_PARTY_ROLE(BOOKING_HASH, PARTY_HASH);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'BOOKING_PARTY_ROLE_PARTY_BOOKING_INDEX') THEN
            CREATE INDEX BOOKING_PARTY_ROLE_PARTY_BOOKING_INDEX 
                ON dv.LINK_BOOKING_PARTY_ROLE(PARTY_HASH, BOOKING_HASH);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'BOOKING_PARTY_ROLE_SOURCE_INDEX') THEN
            CREATE INDEX BOOKING_PARTY_ROLE_PARTY_SOURCE_INDEX 
                ON dv.LINK_BOOKING_PARTY_ROLE(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_BOOKING_DETAILS' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_DETAILS_CDC_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_DETAILS_CDC_INDEX 
                ON dv.SAT_TLINK_BOOKING_DETAILS(BOOKING_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_DETAILS_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_DETAILS_SOURCE_INDEX 
                ON dv.SAT_TLINK_BOOKING_DETAILS(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.LINK_BOOKING_CONVERTS' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'BOOKING_QUOTE_INDEX') THEN
            CREATE INDEX BOOKING_QUOTE_INDEX 
                ON dv.LINK_BOOKING_CONVERTS(BOOKING_HASH, QUOTE_HASH);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'QUOTE_BOOKING_INDEX') THEN
            CREATE INDEX QUOTE_BOOKING_INDEX 
                ON dv.LINK_BOOKING_CONVERTS(QUOTE_HASH, BOOKING_HASH);
        END IF;

    WHEN 'dv.SAT_TLINK_BOOKING_FINANCIALS' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_FINANCIALS_CDC_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_FINANCIALS_CDC_INDEX 
                ON dv.SAT_TLINK_BOOKING_FINANCIALS(BOOKING_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_FINANCIALS_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_FINANCIALS_SOURCE_INDEX 
                ON dv.SAT_TLINK_BOOKING_FINANCIALS(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_BOOKING_PAX' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_PAX_CDC_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_PAX_CDC_INDEX 
                ON dv.SAT_TLINK_BOOKING_PAX(BOOKING_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_PAX_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_PAX_SOURCE_INDEX 
                ON dv.SAT_TLINK_BOOKING_PAX(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY_CDC_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY_CDC_INDEX 
                ON dv.SAT_TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY(BOOKING_CONVERTS_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY_SOURCE_INDEX 
                ON dv.SAT_TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_BOOKING_BOOKING_EFFECTIVITY' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_BOOKING_EFFECTIVITY_CDC_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_BOOKING_EFFECTIVITY_CDC_INDEX 
                ON dv.SAT_TLINK_BOOKING_BOOKING_EFFECTIVITY(BOOKING_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_BOOKING_EFFECTIVITY_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_BOOKING_EFFECTIVITY_SOURCE_INDEX 
                ON dv.SAT_TLINK_BOOKING_BOOKING_EFFECTIVITY(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY_CDC_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY_CDC_INDEX 
                ON dv.SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY(BOOKING_PARTY_ROLE_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY_SOURCE_INDEX 
                ON dv.SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_BOOKING_PARTY_EFFECTIVITY' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_PARTY_EFFECTIVITY_CDC_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_PARTY_EFFECTIVITY_CDC_INDEX 
                ON dv.SAT_TLINK_BOOKING_PARTY_EFFECTIVITY(PARTY_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_PARTY_EFFECTIVITY_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_PARTY_EFFECTIVITY_SOURCE_INDEX 
                ON dv.SAT_TLINK_BOOKING_PARTY_EFFECTIVITY(SOURCE_SYSTEM);
        END IF;
    
    WHEN 'dv.SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS_CDC_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS_CDC_INDEX 
                ON dv.TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS(BOOKING_PARTY_ROLE_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS_SOURCE_INDEX 
                ON dv.SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS(SOURCE_SYSTEM);
        END IF;

--  release 1.002 indexes - agency ----------------------------------------------------------------

    WHEN 'dv.HUB_LOCATOR' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'LOCATOR_SOURCE_INDEX') THEN
            CREATE INDEX LOCATOR_SOURCE_INDEX 
                ON dv.HUB_LOCATOR(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.HUB_GEOGRAPHIC_AREA' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'GEOGRAPHIC_AREA_SOURCE_INDEX') THEN
            CREATE INDEX GEOGRAPHIC_AREA_SOURCE_INDEX 
                ON dv.HUB_GEOGRAPHIC_AREA(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.LINK_PARTY_CONTACT' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'PARTY_CONTACT_PARTY_CONTACT_INDEX') THEN
            CREATE INDEX PARTY_CONTACT_PARTY_CONTACT_INDEX 
                ON dv.LINK_PARTY_CONTACT(PARTY_HASH, LOCATOR_HASH);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'PARTY_CONTACT_CONTACT_PARTY_INDEX') THEN
            CREATE INDEX PARTY_CONTACT_CONTACT_PARTY_INDEX 
                ON dv.LINK_BOOKING_PARTY_ROLE(LOCATOR_HASH, PARTY_HASH);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'PARTY_CONTACT_SOURCE_INDEX') THEN
            CREATE INDEX PARTY_CONTACT_SOURCE_INDEX 
                ON dv.LINK_PARTY_CONTACT(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.LINK_PARTY_GEOGRAPHIC_AREA' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'PARTY_GEOGRAPHIC_AREA_INDEX') THEN
            CREATE INDEX PARTY_GEOGRAPHIC_AREA_INDEX 
                ON dv.LINK_PARTY_GEOGRAPHIC_AREA(PARTY_HASH, GEOGRAPHIC_AREA_HASH);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'GEOGRAPHIC_AREA_PARTY_INDEX') THEN
            CREATE INDEX GEOGRAPHIC_AREA_PARTY_INDEX 
                ON dv.LINK_PARTY_GEOGRAPHIC_AREA(GEOGRAPHIC_AREA_HASH, PARTY_HASH);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'PARTY_GEOGRAPHIC_AREA_SOURCE_INDEX') THEN
            CREATE INDEX PARTY_GEOGRAPHIC_AREA_SOURCE_INDEX 
                ON dv.LINK_PARTY_GEOGRAPHIC_AREA(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_AGENCY_PARTY_DETAILS' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_PARTY_DETAILS_CDC_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_PARTY_DETAILS_CDC_INDEX 
                ON dv.SAT_TLINK_AGENCY_PARTY_DETAILS(PARTY_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_PARTY_DETAILS_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_PARTY_DETAILS_SOURCE_INDEX 
                ON dv.SAT_TLINK_AGENCY_PARTY_DETAILS(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_AGENCY_PARTY_EFFECTIVITY' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_PARTY_EFFECTIVITY_CDC_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_PARTY_EFFECTIVITY_CDC_INDEX 
                ON dv.SAT_TLINK_AGENCY_PARTY_EFFECTIVITY(PARTY_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_PARTY_EFFECTIVITY_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_PARTY_EFFECTIVITY_SOURCE_INDEX 
                ON dv.SAT_TLINK_AGENCY_PARTY_EFFECTIVITY(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_AGENCY_TELEPHONE' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_TELEPHONE_CDC_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_TELEPHONE_CDC_INDEX 
                ON dv.SAT_TLINK_AGENCY_TELEPHONE(LOCATOR_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_TELEPHONE_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_TELEPHONE_SOURCE_INDEX 
                ON dv.SAT_TLINK_AGENCY_TELEPHONE(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_AGENCY_POSTAL_ADDRESS' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_POSTAL_ADDRESS_CDC_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_POSTAL_ADDRESS_CDC_INDEX 
                ON dv.SAT_TLINK_AGENCY_POSTAL_ADDRESS(LOCATOR_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_POSTAL_ADDRESS_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_POSTAL_ADDRESS_SOURCE_INDEX 
                ON dv.SAT_TLINK_AGENCY_POSTAL_ADDRESS(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_AGENCY_LOCATOR_EFFECTIVITY' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_LOCATOR_EFFECTIVITY_CDC_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_LOCATOR_EFFECTIVITY_CDC_INDEX 
                ON dv.SAT_TLINK_AGENCY_LOCATOR_EFFECTIVITY(LOCATOR_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_LOCATOR_EFFECTIVITY_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_LOCATOR_EFFECTIVITY_SOURCE_INDEX 
                ON dv.SAT_TLINK_AGENCY_LOCATOR_EFFECTIVITY(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY_CDC_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY_CDC_INDEX 
                ON dv.SAT_TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY(PARTY_CONTACT_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY_SOURCE_INDEX 
                ON dv.SAT_TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_AGENCY_PARTY_CONTACT' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_PARTY_CONTACT_CDC_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_PARTY_CONTACT_CDC_INDEX 
                ON dv.SAT_TLINK_AGENCY_PARTY_CONTACT(PARTY_CONTACT_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_PARTY_CONTACT_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_PARTY_CONTACT_SOURCE_INDEX 
                ON dv.SAT_TLINK_AGENCY_PARTY_CONTACT(SOURCE_SYSTEM);
        END IF;

    WHEN 'dv.SAT_TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY' THEN
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY_CDC_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY_CDC_INDEX 
                ON dv.SAT_TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY(PARTY_GEOGRAPHIC_AREA_HASH, LOAD_DATETIME, CDC_HASH, EFFECTIVE_FROM, EFFECTIVE_TO);
        END IF;
        IF NOT HAS_INDEX('dv', TABLENAME, 'TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY_SOURCE_INDEX') THEN
            CREATE INDEX TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY_SOURCE_INDEX 
                ON dv.SAT_TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY(SOURCE_SYSTEM);
        END IF;

--  end - capture error, name provided does not exist ---------------------------------------------

ELSE
            SET msgText = concat('Table ', caseTable, ' not found in create_index procedure.');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msgText;
    
    END CASE;

END //

DELIMITER ;
