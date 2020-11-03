# =============================================================================
# SCRIPT: Reset Indexes
#
# Purpose:
#   Drop and recreate all indexes - to ensure thay are clean and complete.
#
# Description:
#   Invoke the stored procedure for each table to drop and create indexes.
#   If there are specific indexes to be dropped that are not to be recreated 
#   for this release increment then add them as an extra drop index command
#   before the stored procedure is invoked (that particular drop index will not
#   be in the drop index procedure as it is not valid for this release, but will
#   still be in the database from the previous release).
#
# Release History:
#   Date     Who Changes Made
#   -------- --- --------------------------------------------------------------
#   14.02.17 NS  Version 1.0
#   18.05.17 TW  Debugged
#   23.05.17 TW  Added dv.SAT_BUS_HOLDBACK indexes
#   30.05.17 TW  Added indexes for effectivity satellite tables
#   09.06.17 NS  Added tables as indexing added to hubs, links and more sats
#   20.07.17 NS  Amended Sat effectivity names, sat_eff._party dropped. added booking_converts eff satellite
#   30.07.17 NS  Amended some table names to align with standards, removed holdbacks
#   18.08.17 NS  Added AGENCY details, release 2.
#   21.08.17 TW  Added statements for table SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS
#
# =============================================================================

# -- RELEASE 1.001 BOOKING ----------------------------------
# reset indexes
CALL dv.DROP_INDEX('dv', 'HUB_BOOKING');
CALL dv.CREATE_INDEX('dv', 'HUB_BOOKING');

CALL dv.DROP_INDEX('dv', 'HUB_PARTY');
CALL dv.CREATE_INDEX('dv', 'HUB_PARTY');

CALL dv.DROP_INDEX('dv', 'LINK_BOOKING_PARTY_ROLE');
CALL dv.CREATE_INDEX('dv', 'LINK_BOOKING_PARTY_ROLE');

CALL dv.DROP_INDEX('dv', 'LINK_BOOKING_CONVERTS');
CALL dv.CREATE_INDEX('dv', 'LINK_BOOKING_CONVERTS');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_BOOKING_DETAILS');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_BOOKING_DETAILS');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_BOOKING_FINANCIALS');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_BOOKING_FINANCIALS');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_BOOKING_PAX');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_BOOKING_PAX');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_BOOKING_BOOKING_EFFECTIVITY');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_BOOKING_BOOKING_EFFECTIVITY');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_BOOKING_PARTY_EFFECTIVITY');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_BOOKING_PARTY_EFFECTIVITY');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_BOOKING_BOOKING_CONVERTS_EFFECTIVITY');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_EFFECTIVITY');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_BOOKING_BOOKING_PARTY_ROLE_DETAILS');

# -- RELEASE 1.002 AGENCY -----------------------------------
# reset indexes
CALL dv.DROP_INDEX('dv', 'SAT_TLINK_AGENCY_PARTY_EFFECTIVITY');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_AGENCY_PARTY_EFFECTIVITY');

CALL dv.DROP_INDEX('dv', 'HUB_LOCATOR');
CALL dv.CREATE_INDEX('dv', 'HUB_LOCATOR');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_AGENCY_LOCATOR_EFFECTIVITY');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_AGENCY_LOCATOR_EFFECTIVITY');

CALL dv.DROP_INDEX('dv', 'HUB_GEOGRAPHIC_AREA');
CALL dv.CREATE_INDEX('dv', 'HUB_GEOGRAPHIC_AREA');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_AGENCY_GEOGRAPHIC_AREA_EFFECTIVITY');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_AGENCY_GEOGRAPHIC_AREA_EFFECTIVITY');

CALL dv.DROP_INDEX('dv', 'LINK_PARTY_CONTACT');
CALL dv.CREATE_INDEX('dv', 'LINK_PARTY_CONTACT');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_AGENCY_PARTY_CONTACT_DETAILS');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_AGENCY_PARTY_CONTACT_DETAILS');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_AGENCY_PARTY_CONTACT_EFFECTIVITY');

CALL dv.DROP_INDEX('dv', 'LINK_PARTY_GOEOGRAPHIC_AREA');
CALL dv.CREATE_INDEX('dv', 'LINK_PARTY_GEOGRAPHIC_AREA');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_AGENCY_PARTY_GEOGRAPHIC_AREA_EFFECTIVITY');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_AGENCY_TELEPHONE');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_AGENCY_TELEPHONE');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_AGENCY_POSTAL_ADDRESS');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_AGENCY_POSTAL_ADDRESS');

CALL dv.DROP_INDEX('dv', 'SAT_TLINK_AGENCY_PARTY_DETAILS');
CALL dv.CREATE_INDEX('dv', 'SAT_TLINK_AGENCY_PARTY_DETAILS');
