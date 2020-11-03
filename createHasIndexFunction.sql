# =============================================================================
# SCRIPT: CREATE HAS_INDEX FUNCTION
#
# Purpose:
#   The CREATE_INDEX and DROP_INDEX procedures need to check if an index
#   already exists. This function performs that check.
#
# Description:
#   This function is used widely by the indexing procedures to find out if an
#   index already exists. It returns a boolean (integer) with the value of 0
#   if no index exists or 1 if one does exist.
#
# Release History:
#   Date     Who Changes Made
#   -------- --- --------------------------------------------------------------
#   14.02.17 NS  Version 1.0
#   18.05.17 TW  Debugged
#
# =============================================================================

# ----------------------------------------------
# clear down existing copy prior to insert
DROP FUNCTION IF EXISTS dv.HAS_INDEX;

# ----------------------------------------------
# create a function to test if an index exists given a table and index name

DELIMITER //

CREATE FUNCTION dv.HAS_INDEX(SCHEMANAME VARCHAR(100), TABLENAME VARCHAR(100), INDEXNAME VARCHAR(100)) 
	RETURNS integer NOT DETERMINISTIC
BEGIN	
	DECLARE index_exists integer;
	set index_exists = 
        (
         select count(*) from information_schema.statistics as A
		where A.TABLE_SCHEMA = SCHEMANAME and A.TABLE_NAME = TABLENAME and A.INDEX_NAME = INDEXNAME
		and A.TABLE_SCHEMA not in ('information_schema','mysql','performance_schema')
        )
        > 0;
	RETURN(index_exists);
END //

DELIMITER ;

# test cases
# select HAS_INDEX('dv', 'HUB_BOOKING', NULL);  -- 0
# select HAS_INDEX('dv', 'HUB_BOOKING', '');  -- 0
# select HAS_INDEX('NOTASCHEMA', 'HUB_BOOKING', 'PRIMARY');  -- 0
# select HAS_INDEX('dv', 'NOTATABLE', 'PRIMARY');  -- 0
# select HAS_INDEX('dv', 'HUB_BOOKING', 'NOTANINDEX');  -- 0
# select HAS_INDEX('dv', 'HUB_BOOKING', 'PRIMARY');  -- 1
# select HAS_INDEX('dv', 'LINK_BOOKING_PARTY_ROLE', 'BOOKING_PARTY_ROLE_BOOKING_PARTY_INDEX');  -- 1
