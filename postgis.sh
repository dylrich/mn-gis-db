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
\i /usr/local/bin/data/ctu.sql
\i /usr/local/bin/data/water_bodies.sql
\i /usr/local/bin/data/road_network.sql
\i /usr/local/bin/data/osm_line.sql
\i /usr/local/bin/data/osm_point.sql
\i /usr/local/bin/data/osm_polygon.sql
\i /usr/local/bin/data/osm_roads.sql
\i /usr/local/bin/data/aadt.sql
\i /usr/local/bin/data/bikeways.sql
\i /usr/local/bin/data/block_groups_2000.sql
\i /usr/local/bin/data/block_groups_2010.sql
\i /usr/local/bin/data/congressional_districts.sql
\i /usr/local/bin/data/counties.sql
\i /usr/local/bin/data/dp_tract_2010.sql
\i /usr/local/bin/data/railways.sql
\i /usr/local/bin/data/school_districts.sql
\i /usr/local/bin/data/taz.sql
\i /usr/local/bin/data/tracts_2000.sql
\i /usr/local/bin/data/tracts_2010.sql
\i /usr/local/bin/data/transit_routes.sql
\i /usr/local/bin/data/transit_stops.sql




COMMIT;
SQLEND
