# =========================================================================================================================================
# SCRIPT TO INSERT LOOKUP DATA
#
# Description:
#  This script inserts Vault lookup data used to code columns within the database.
#
# Release History:
#   Date     Who Changes Made
#   -------- --- --------------------------------------------------------------------------------------------------------------------------
#   28.04.17 NS  Version 1.0
#
# =========================================================================================================================================

# -----------------------------------------------------------------------------------------------------------------------------------------
# TRUNCATE EXISTING DATA
# -----------------------------------------------------------------------------------------------------------------------------------------
truncate ctrl.LAKE_ETL_LOOKUP;


# =========================================================================================================================================
# LOOKUP CODES FOR SOURCE SYSTEM DATABASES AND TABLES, FOR USE IN THE SOURCE_SYSTEM METADATA COLUMN IN THE VAULT
# =========================================================================================================================================

insert into ctrl.LAKE_ETL_LOOKUP (SOURCE_SYSTEM_ID, SOURCE_SYSTEM_NAME, SOURCE_TABLE)
values
    (1, "TRAVELINK", "AGENCY"),
    (2, "TRAVELINK", "BOOKINGS"),
    (3, "TRAVELINK", "SUPPLIERS"),
    (4, "TRAVELINK", "FLIGHTS"),
    (5, "TRAVELINK", "AGENCYGROUP"),
    (6, "TRAVELINK", "PASSENGERS"),
    (7, "TRAVELINK", "SUBREGIONS"),
    (8, "TRAVELINK", "COUNTRIES"),
    (9, "TRAVELINK", "HOLIDAYMASTERRECORD"),
    (10, "TRAVELINK", "HOLIDAYUNITRECORD"),
    (11, "TRAVELINK", "FLIGHTDET"),
    (12, "TRAVELINK", "ACCOMDET"),
    (13, "TRAVELINK", "RESORT"),
    (14, "TRAVELINK", "VIEW_BOOKINGPRICES"),
    (15, "TRAVELINK", "VIEW_BOOKINGCOSTS"),
    (16, "SPREADSHEET", "HOLDBACKS"),
    (17, "TRAVELINK", "AIRPORT_RESORT_LINK"),
    (18, "TRAVELINK", "PROJECTS"),
    (19, "TRAVELINK", "CAR_DET"),
    (20, "TRAVELINK", "CAR_HIRE"),
    (21, "TRAVELINK", "TRANSFERS"),
    (22, "TRAVELINK", "TRANSFERS_DET"),
    (23, "TRAVELINK", "TOUR_DET"),
    (24, "TRAVELINK", "TOURSIND"),
    (25, "TRAVELINK", "GROUPRICING"),
    (26, "TRAVELINK", "BOOKINGCOSTS"),
    (27, "TRAVELINK", "EXTRASSALES"),
    (28, "TRAVELINK", "BOOKINGCOMMISSION"),
    (29, "TRAVELINK", "VEHICLES"),
    (30, "TRAVELINK", "EXTRAS"),
    (31, "TRAVELINK", "TOURBOOKINGCOMPONENTSTATUSES"),
    (32, "TRAVELINK", "FLIGHTCONTRACTS_DET"),
    (33, "TRAVELINK", "LINKPAXTOFLIGHTS"),
    (34, "TRAVELINK", "FLIGHTCONTRACTS"),
    (35, "TRAVELINK", "LINKPAXTOROOMS"),
    (36, "TRAVELINK", "LINKPAXTOEXTRAS"),
    (37, "TRAVELINK", "LINKPAXTOTOUR"),
    (38, "TRAVELINK", "QUOTATION"),
    (39, "TRAVELINK", "QUOTATIONDETAIL"),
    (40, "VAULT", "BUSINESS_RULE"),
    (41, "MANUAL", "CONSTRAINED_LIST"),
    (42, "TRAVELINK", "PRODUCT_MASTER"),
    (43, "TRAVELINK", "VIEW_EUR_MI_TOMS");

# =========================================================================================================================================
# OTHER CODES, BASED ON A VIEW
# =========================================================================================================================================

insert into ctrl.CONSTRAINED_LISTS (LIST_NAME, CODE, DESCRIPTION, IS_ACTIVE)
values
    ("EFFECTIVITY_STATUS", 1, "ACTIVE", 1),
    ("EFFECTIVITY_STATUS", 2, "DELETED", 1);
