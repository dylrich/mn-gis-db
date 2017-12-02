#!/bin/sh

set -e

# Make mn_gis Database
"${psql[@]}" --username="$POSTGRES_USER" << SQLEND
CREATE DATABASE mn_gis;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'mn_gis';
SQLEND

# Create extensions

"${psql[@]}" --username="$POSTGRES_USER" --dbname=mn_gis << SQLEND
	CREATE EXTENSION postgis;
	CREATE EXTENSION postgis_topology;
	CREATE EXTENSION fuzzystrmatch;
	CREATE EXTENSION postgis_tiger_geocoder;
	CREATE EXTENSION pgrouting;
SQLEND

# Populate mn_gis with datasets

"${psql[@]}" --username="$POSTGRES_USER" --dbname=mn_gis << SQLEND
BEGIN;
\i /usr/local/bin/shp/ctu.sql
\i /usr/local/bin/shp/water_bodies.sql

COMMIT;
SQLEND
