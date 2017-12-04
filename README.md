# MN-PostGIS-Docker
A Docker container which initializes a PostGIS and pgrouting-enabled database and is pre-populated with curated datasets from the Minneapolis/Saint Paul metro area. Datasets are set up to be easily queried.

# Usage

This database requires the use of Docker. You can get Docker for [Windows](https://www.docker.com/docker-windows), [Mac](https://www.docker.com/docker-mac), or several Linux distributions. After installing the software, open up a terminal. You can download this repository's auto-built image from DockerHub and initialize an instance of the image by using the following command:

`
docker run --name mn-gis -e POSTGRES_PASSWORD=gis -d dylrich/mn-postgis
`

This command launches a Docker image running in the background on your computer. Because this image is an extension of the PostgreSQL 10 official image, it will run under Ubuntu Linux and expose port 5432 by default. If you have PostgreSQL already installed and running on your system, this can make connecting from a utility like pgAdmin difficult. To get around this, I would suggest changing the port that is exposed from the docker image like so:

`
docker run --name mn-gis -e POSTGRES_PASSWORD=gis -p 26915:5432 -d dylrich/mn-postgis
`

Now you may detect the database on port 26915 from your own computer at the default IP address of 127.0.0.1. Alternatively, you can connect to the database from another image with the following command:

`
docker run -it --rm --link mn-gis:postgres postgres psql -h postgres -U postgres -p 5432 -W gis
`


# Included Datasets
Table name in database | Description | Data source | Schema reference
---------------------- | ----------- | ----------- | ----------------
water_bodies | Surface water with areas larger than .4 acres, including both rivers and lakes | [Metropolitan Council](https://gisdata.mn.gov/dataset/us-mn-state-metc-water-lakes-rivers) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
ctu | Cities, townships, and unorganized territories | [MNDOT](https://gisdata.mn.gov/dataset/bdry-mn-city-township-unorg) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
osm_lines | Open Street Map's lines dataset | [Mapzen's OSM extracts](https://mapzen.com/data/metro-extracts/metro/minneapolis-saint-paul_minnesota/) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
osm_points | Open Street Map's points dataset | [Mapzen's OSM extracts](https://mapzen.com/data/metro-extracts/metro/minneapolis-saint-paul_minnesota/) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
osm_polygons | Open Street Map's polygons dataset | [Mapzen's OSM extracts](https://mapzen.com/data/metro-extracts/metro/minneapolis-saint-paul_minnesota/) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
osm_roads | Open Street Map's roads dataset | [Mapzen's OSM extracts](https://mapzen.com/data/metro-extracts/metro/minneapolis-saint-paul_minnesota/) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
road_network | Pgrouting-enabled network dataset converted from OSM data with osm2po | [Mapzen's OSM extracts](https://mapzen.com/data/metro-extracts/metro/minneapolis-saint-paul_minnesota/) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
aadt | Average annual daily traffic based on MNDOT road designations | [MNDOT](https://gisdata.mn.gov/dataset/trans-aadt-traffic-segments) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
transit_stops | Transit stops serviced by Metro Transit | [Metropolitan Council](https://gisdata.mn.gov/dataset/us-mn-state-metc-trans-transit-stops) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
transit_routes | Transit routes serviced by Metro Transit | [Metropolitan Council](https://gisdata.mn.gov/dataset/us-mn-state-metc-trans-transit-routes) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
railways | Rail lines as defined by MNDOT | [MNDOT](https://gisdata.mn.gov/dataset/trans-rail-lines) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
bikeways | Regional bikeways with classifications | [Metropolitan Council](https://gisdata.mn.gov/dataset/us-mn-state-metc-trans-bikeways) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
transportation_analysis_zones | TAZ boundaries with current forecasts | [Metropolitan Council](https://gisdata.mn.gov/dataset/us-mn-state-metc-trans-anlys-zones-offical-curent) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
school_districts | Academic year 2017-2018 school district boundaries | [MNDOE](https://gisdata.mn.gov/dataset/bdry-school-district-boundaries) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
block_groups | Block groups from 2010 decennial census | [U.S. Census Bureau](https://www.census.gov/geo/maps-data/data/tiger-line.html) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
census_tracts | Census tracts from 2010 decennial census | [U.S. Census Bureau](https://www.census.gov/geo/maps-data/data/tiger-line.html) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
counties_cities_townships | Counties, cities, and townships polygons | [Metropolitan Council](https://gisdata.mn.gov/dataset/us-mn-state-metc-bdry-census2010counties-ctus) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
congressional_districts | Congressional districts from 2010 redistricting | [LCC-GIS](https://gisdata.mn.gov/dataset/bdry-congressionaldistricts2012) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
dem | 30 meter resolution DEM | [MNDNR](https://gisdata.mn.gov/dataset/elev-30m-digital-elevation-model) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
tract_2010_demographic_profile | Selected demographic data from 2010 decennial census | [U.S. Census Bureau](https://www.census.gov/geo/maps-data/data/tiger-data.html) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)


# Sample Queries
