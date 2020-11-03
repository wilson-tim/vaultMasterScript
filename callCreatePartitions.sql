# =============================================================================
# SCRIPT: CREATE PARTITIONS
#
# Purpose:
#   Ensure that partitions are configured correctly in the VAULT.
#
# Description:
#   Call the CREATE_PARTITIONS() stored procedure.
#
# Release History:
#   Date     Who Changes Made
#   -------- --- --------------------------------------------------------------
#   19.05.17 TW  Version 1.0
#
# =============================================================================

------------------------------------
# create partitions
CALL dv.CREATE_PARTITIONS();
