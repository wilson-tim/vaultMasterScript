# =============================================================================
# SCRIPT: SECURITY PERMISSIONS
#
# Purpose:
#   Set up access rights plus procedures to create new user profiles.
#
# Description:
#   Creates procedures that in turn create users and manage access rights.
#
# Release History:
#   Date     Who Changes Made
#   -------- --- --------------------------------------------------------------
#   07.04.17 NS  Version 1.0
#   19.05.17 TW  Debugged - GRANT statements are rather tricky to soft code!
#    
# =============================================================================

#--------------------------------------
# Deployment User Rights
#--------------------------------------
DROP PROCEDURE IF EXISTS dv.CREATE_DEPLOYMENT_PROFILE;

DELIMITER //
CREATE PROCEDURE dv.CREATE_DEPLOYMENT_PROFILE (IN USERNAME VARCHAR(32), IN USERHOST VARCHAR(64))

BEGIN

SET @sqlString = CONCAT('GRANT ALL ON *.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

END //
DELIMITER ;

#--------------------------------------
# Developer User Rights
#--------------------------------------
DROP PROCEDURE IF EXISTS dv.CREATE_ADMIN_USER_PROFILE;

DELIMITER //
CREATE PROCEDURE dv.CREATE_ADMIN_USER_PROFILE (IN USERNAME VARCHAR(32), IN USERHOST VARCHAR(64))

BEGIN

SET @sqlString = CONCAT('GRANT ALL ON *.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

END //
DELIMITER ;

#--------------------------------------
# Developer User Rights
#--------------------------------------
DROP PROCEDURE IF EXISTS dv.CREATE_DEVELOPER_PROFILE;

DELIMITER //
CREATE PROCEDURE dv.CREATE_DEVELOPER_PROFILE (IN USERNAME VARCHAR(32), IN USERHOST VARCHAR(64))

BEGIN

SET @sqlString = CONCAT('GRANT ALL ON *.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

END //
DELIMITER ;

#--------------------------------------
# ETL User Rights
#--------------------------------------
DROP PROCEDURE IF EXISTS dv.GRANT_ETL_PROFILE;

DELIMITER //
CREATE PROCEDURE dv.GRANT_ETL_PROFILE (IN USERNAME VARCHAR(32), IN USERHOST VARCHAR(64))

BEGIN

SET @sqlString = CONCAT('GRANT SELECT, INSERT, UPDATE, EXECUTE, INDEX, CREATE VIEW, ALTER ON dv.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

SET @sqlString = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE, INDEX, CREATE VIEW, ALTER ON martLegacy.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

SET @sqlString = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE, INDEX, CREATE VIEW, ALTER ON martKPI.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

SET @sqlString = CONCAT('GRANT INSERT ON logs.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

SET @sqlString = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE, DROP, INDEX, CREATE, CREATE VIEW ON stg.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

SET @sqlString = CONCAT('GRANT SELECT, INSERT, UPDATE ON ctrl.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

END //
DELIMITER ;

#--------------------------------------
# martLegacy User Rights
#--------------------------------------
DROP PROCEDURE IF EXISTS dv.GRANT_MARTLEGACY_USER_PROFILE;

DELIMITER //
CREATE PROCEDURE dv.GRANT_MARTLEGACY_USER_PROFILE (IN USERNAME VARCHAR(32), IN USERHOST VARCHAR(64))

BEGIN

SET @sqlString = CONCAT('GRANT SELECT ON martLegacy.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

END //
DELIMITER ;

#--------------------------------------
# martKPI User Rights
#--------------------------------------
DROP PROCEDURE IF EXISTS dv.GRANT_MARTKPI_USER_PROFILE;

DELIMITER //
CREATE PROCEDURE dv.GRANT_MARTKPI_USER_PROFILE (IN USERNAME VARCHAR(32), IN USERHOST VARCHAR(64))

BEGIN

SET @sqlString = CONCAT('GRANT SELECT ON martKPI.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;
    

END //
DELIMITER ;

#--------------------------------------
# vaultUser User Rights
#--------------------------------------
DROP PROCEDURE IF EXISTS dv.GRANT_VAULT_USER_PROFILE;

DELIMITER //
CREATE PROCEDURE dv.GRANT_VAULT_USER_PROFILE (IN USERNAME VARCHAR(32), IN USERHOST VARCHAR(64))

BEGIN

SET @sqlString = CONCAT('GRANT SELECT ON dv.* TO ''', USERNAME, '''', '@', '''', USERHOST, '''');
-- SELECT @sqlString;  -- For debugging
PREPARE execString FROM @sqlString;
EXECUTE execString;
DEALLOCATE PREPARE execString;

END //
DELIMITER ;

#--------------------------------------
# invoke procedures to create users with appropriate permissions
#--------------------------------------

CREATE USER 'neil_strange'@'%';
CALL dv.CREATE_DEVELOPER_PROFILE('neil_strange', '%');

CREATE USER 'tim_wilson'@'%';
CALL dv.CREATE_DEVELOPER_PROFILE('tim_wilson', '%');

CREATE USER 'mike_morse'@'%';
CALL dv.CREATE_ADMIN_USER_PROFILE('mike_morse', '%');

CREATE USER 'murali_gongati'@'%';
CALL dv.CREATE_DEVELOPER_PROFILE('murali_gongati', '%');

CREATE USER 'etl'@'%';
CALL dv.GRANT_ETL_PROFILE('etl', '%');

CREATE USER 'mart_legacy'@'%';
CALL dv.GRANT_MARTLEGACY_USER_PROFILE('mart_legacy', '%');

CREATE USER 'mart_kpi'@'%';
CALL dv.GRANT_MARTKPI_USER_PROFILE('mart_kpi', '%');

# test cases
# CREATE USER 'vault_user'@'%';
# CALL dv.GRANT_VAULT_USER_PROFILE('vault_user', '%');

# CREATE USER 'vault_user'@'localhost';
# CALL dv.GRANT_VAULT_USER_PROFILE('vault_user', 'localhost');

# CREATE USER 'etl_user'@'localhost';
# CALL dv.GRANT_ETL_PROFILE('etl_user', 'localhost');

