# MN-PostGIS-Docker
A Docker container which initializes a PostGIS 2.4 and pgrouting-enabled PostgreSQL 10 database and is pre-populated with curated datasets from the Minneapolis/Saint Paul metro area. Datasets are set up to be easily queried.

# Usage


### Setup and running an instance

This database requires the use of Docker. You can get Docker for [Windows](https://www.docker.com/docker-windows), [Mac](https://www.docker.com/docker-mac), or several Linux distributions. After installing the software, open up a terminal. You can download this repository's auto-built image from DockerHub with the following command:

```
docker pull dylrich/mn-postgis:latest
```

Once the image has been downloaded, you can launch the Docker container and create a new PostGIS database with:

```
docker run --name mn-gis -e POSTGRES_PASSWORD=gis -d dylrich/mn-postgis:latest
```

The above command launches a Docker image running in the background on your computer. Because this image is an extension of the PostgreSQL 10 official image, it will run under Ubuntu Linux and expose port 5432 by default. If you have PostgreSQL already installed and running on your system, this can make connecting from a utility like pgAdmin difficult. To get around this, I would suggest changing the port that is exposed from the docker image like so:

```
docker run --name mn-gis -e POSTGRES_PASSWORD=gis -p 26915:5432 -d dylrich/mn-postgis:latest
```

Now you may detect the database on port 26915 from your own computer at the default IP address of 127.0.0.1. Alternatively, you can connect to the database from another image with the following command:

```
docker run -it --rm --link mn-gis:postgres postgres psql -h postgres -U postgres -p 5432 -W gis
```

### Reference Information

It is important to note that all of the automatically loaded data is in UTM 15N NAD 83, or EPSG SRID 26915. All spatial operations between preloaded datasets work out of the box. If you are going to add in new data, make sure you properly set its SRID to 26915 or reproject as needed.

If you run the above commands your database will have the following defaults:

Parameter | Value
--------- | -----
hostname | 127.0.0.1
user | postgres
port | 26915 or 5432
password | gis
database | mn_gis
schema | public

# Included Datasets
Table name in database | Description | Data source | Schema reference
---------------------- | ----------- | ----------- | ----------------
water_bodies | Surface water with areas larger than .4 acres, including both rivers and lakes | [Metropolitan Council](https://gisdata.mn.gov/dataset/us-mn-state-metc-water-lakes-rivers) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
ctu | Cities, townships, and unorganized territories in polygon form | [MNDOT](https://gisdata.mn.gov/dataset/bdry-mn-city-township-unorg) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
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
counties | County polygons for the 7 county metro area | [Metropolitan Council](https://gisdata.mn.gov/dataset/us-mn-state-metc-bdry-census2010counties-ctus) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
congressional_districts | Congressional districts from 2010 redistricting | [LCC-GIS](https://gisdata.mn.gov/dataset/bdry-congressionaldistricts2012) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
dem | 30 meter resolution DEM | [MNDNR](https://gisdata.mn.gov/dataset/elev-30m-digital-elevation-model) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
tract_2010_demographic_profile | Selected demographic data from 2010 decennial census | [U.S. Census Bureau](https://www.census.gov/geo/maps-data/data/tiger-data.html) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
metro_parcels_poly | Parcel polygons for the 7 county metro area | [MetroGIS](https://gisdata.mn.gov/dataset/us-mn-state-metrogis-plan-regonal-prcls-open) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)
metro_parcels_point | Parcel centerpoints for the 7 county metro area | [MetroGIS](https://gisdata.mn.gov/dataset/us-mn-state-metrogis-plan-regonal-prcls-open) | [Schema](https://github.com/dylrich/mn-postgis-docker/wiki/water_bodies-reference)


# Sample Queries

This section contains some example queries which you can use as a cookbook for other analysis you'd like to do.

### Working with Census demographic data

```sql
CREATE view dp_2010 AS (SELECT * FROM (SELECT gid AS tract_gid, countyfp10, tractce10, geoid10, name10, geom AS tract_geom FROM tracts_2010) AS tract, dp_tract_2010 dp WHERE dp."GEO.id2" = tract.geoid10);
```

```SQL
CREATE view metro_dp AS (SELECT * FROM dp_2010 d, (SELECT gid AS co_gid, co_code, co_name, geom AS co_geom FROM counties) AS c WHERE d.countyfp10 = c.co_code);
```

### Working with pgrouting and the road network

A pre-built routing network is available in the `road_network` 

1. Adjust the road network's `cost` attribute to be in minutes instead of hours

```sql
CREATE VIEW road_network_mins AS(
 SELECT road_network.id,
    road_network.source,
    road_network.target,
    road_network.cost * 60 AS cost,
    road_network.reverse_cost * 60 AS reverse_cost
   FROM road_network
   );
```

2. Create a table of all nodes in the network to use for the convex hull

```sql
CREATE VIEW nodes AS(
 SELECT road_network.source AS node,
    st_startpoint(road_network.geom_way) AS geom
   FROM road_network
UNION
 SELECT road_network.target AS node,
    st_endpoint(road_network.geom_way) AS geom
   FROM road_network);
``` 

3. Find the geometry for the point location you are interested in

```sql
CREATE VIEW target_center AS(
SELECT addresses.address,
    addresses.geom
   FROM (SELECT concat(parcel_points.bldg_num, ' ', parcel_points.streetname) AS address,
    parcel_points.geom FROM parcel_points) addresses
  WHERE addresses.address = '600 1ST AVE N');
```



4. Find the node closest to your point location which you can use as a starting point

```sql
CREATE VIEW tc_nn AS (
SELECT nodes.node, nodes.geom, target_center.address
FROM nodes, target_center
ORDER BY ST_Distance(nodes.geom,target_center.geom) 
LIMIT 1);
```

5. Create a convex hull of all nodes where the driving time is less than 10 minutes

```sql
SELECT ST_ConvexHull(pt.geom) FROM (SELECT dist.seq, dist.node, dist.edge, dist.cost, dist.agg_cost, nodes.geom FROM PGR_DrivingDistance(
  'SELECT id, source, target, cost FROM edges',
  (SELECT tc_nn.geom FROM tc_nn), 10000000) dist, road_nodes nodes
WHERE dist.node = nodes.node AND agg_cost < 10) AS pt
```

### Working with rasters