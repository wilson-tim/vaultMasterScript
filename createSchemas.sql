# =============================================================================
# SCRIPT: CREATE SCHEMAS
#
# Purpose:
#   Create schemas to logically separate different data sets in the database.
#
# Description:
#   This script creates schemas to support the Data Vault and Marts. It is
#   idempotent - it creates schemas where they do not exist.
#
# Release History:
#   Date     Who Changes Made
#   -------- --- --------------------------------------------------------------
#   14.02.17 NS  Version 1.0
#   26.05.17 NS  Added martReconcile schema
#   02.07.17 NS  Added martLegacyTLINK, removed martLegacy for now
#
# =============================================================================

create schema if not exists ctrl;            -- holds loader control data
create schema if not exists logs;            -- holds the log tables
create schema if not exists stg;             -- used to stage data
create schema if not exists dv;              -- holds the data vault (raw and business)
create schema if not exists martKPI;         -- holds KPI metrics mart
create schema if not exists martReconcile;   -- holds meta data and reference sets
create schema if not exists martLegacyTLINK; -- holds the TLINK presentation layer mock
create schema if not exists meta;            -- holds meta data and reference sets
create schema if not exists metrics;         -- holds the metrics mart (telemetry)