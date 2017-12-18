# MN-PostGIS-Docker
A Docker container which initializes a PostGIS 2.4 and pgrouting-enabled PostgreSQL 10 database and is pre-populated with curated datasets from the Minneapolis/Saint Paul metro area. Datasets are set up to be easily queried.

# Usage

## Setup and running an instance

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

#### Note: If you try to run the above commands and receive "Error response from daemon: driver failed programming external connectivity on endpoint mn-gis", restart your Docker daemon by manually ending the service and activating it. This appears to be a Windows-related bug.

## Connecting to the container with pgAdmin, ArcMap/ArcPro, QGIS, or the terminal

For a step-by-step guide to connecting to the database with your favorite application, [please visit this page](https://github.com/dylrich/mn-postgis-docker/wiki/Tutorial:-Connecting-to-the-database). The guides located at that page demonstrate connecting with popular GUI applications and the terminal. If you are having trouble with your application of choice, please open an issue with your circumstances.

## Reference Information

All of the automatically loaded data is in UTM 15N NAD 83, or EPSG SRID 26915. All spatial operations between preloaded datasets work out of the box. If you are going to add in new data, make sure you properly set its SRID to 26915 or reproject as needed.

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

## Working with Census demographic data

There are several Census datasets in this database which were collected in different years and are aggregated to different geographies. If you're not sure how the Census Bureau tabulates their data or what some terms mean, take a look at [their terms and concepts reference](https://www.census.gov/geo/reference/terms.html).

### Joining Census non-spatial tables to a spatial geography

By default, Census datasets are not distributed with spatial information. This means you will need to take the tables which contain spatial information, such as `census_tracts` or `block_groups` and join them to the census dataset you are interested in. You may then perform spatial queries on the census datasets. In the below example we will use the 2010 decennial census demographic profile dataset to illustrate this process.

#### 1. Join the demographic profile table to Census tracts spatial dataset

```sql
CREATE VIEW dp_2010 AS (
  SELECT * 
  FROM (
    SELECT gid AS tract_gid, countyfp10, tractce10, geoid10, name10, geom AS tract_geom
    FROM tracts_2010) AS tract, dp_tract_2010 AS dp
    WHERE dp."GEO.id2" = tract.geoid10);
```

#### 2. Select only tracts which are part of the seven county metro area

```sql
CREATE VIEW metro_dp AS (
  SELECT *
  FROM dp_2010 AS d, (
    SELECT gid AS co_gid, co_code, co_name, geom AS co_geom
    FROM counties) AS c
    WHERE d.countyfp10 = c.co_code);
```

## Working with pgrouting and the road network

A pre-built routing network is available in the `road_network` table. The network dataset is built from OSM data with the help of the osm2po tool. The following two examples will show queries you can perform with the road network to answer common network questions.

### Generating drive time buffers from a single point

A commonly asked question in the spatial world is "How long does it take to get from A to B?" The `road_network` table can help you answer that question, though it is important to note that we do not have access to proprietary traffic data, and therefore can only incorporate distance and speed limits into our analysis. Regardless, this type of query can help determine service areas, supply chain timing, and other useful information. We are going to use the Target Center in Minneapolis as our point of interest and generate a 10 minute drive time buffer around it.

#### 1. Adjust the road network's `cost` attribute to be in minutes instead of hours
```sql
CREATE VIEW road_network_mins AS(
 SELECT id, source, target, cost * 60 AS cost, reverse_cost * 60 AS reverse_cost, kmh, geom_way as geom
   FROM road_network);
```

#### 2. Create a table of all nodes in the network to use for the concave hull
```sql
CREATE VIEW nodes AS(
 SELECT source AS node,
    st_startpoint(geom) AS geom
   FROM road_network_mins
UNION
 SELECT target AS node,
    st_endpoint(geom) AS geom
   FROM road_network_mins);
``` 

#### 3. Find the geometry for the point location you are interested in (Target Center)

Note: Here we are using the `parcel_points` table to grab the Target Center's point data based on its known address. There are many methods that work here, and you may use any of them to generate a table with one point for a starting location. If you are interested in queries with multiple start locations, you can manually re-run the following sequence of queries for each location, or you may adapt the method shown in the second example below
```sql
CREATE VIEW target_center AS(
  SELECT addresses.address, addresses.geom
  FROM (
     SELECT concat(parcel_points.bldg_num, ' ', parcel_points.streetname) AS address, parcel_points.geom
     FROM parcel_points) addresses
  WHERE addresses.address = '600 1ST AVE N');
```

#### 4. Find the node closest to your point location (Target Center) which you can use as a starting point

Note: Other query structures work for this step, but this method supports multiple input addresses in case you are performing a query with multiple starting nodes
```sql
CREATE VIEW tc_nn AS (
SELECT DISTINCT ON(target_center.address) nodes.node, nodes.geom, target_center.address
FROM nodes, target_center
ORDER BY target_center.address, ST_Distance(nodes.geom,target_center.geom));
```

#### 5. Create a concave hull of all nodes where the driving time is less than 10 minutes

Note: You can experiment with different ConcaveHull operation parameters to achieve your desired result. Allowing holes can be turned off by changing TRUE to FALSE, and you can make the hull look more like a convex hull by increasing the tolerance value.
```sql
SELECT ST_ConcaveHull(ST_Collect(pt.geom), .75, TRUE)
FROM (
  SELECT dist.seq, dist.node, dist.edge, dist.cost, dist.agg_cost, nodes.geom
  FROM PGR_DrivingDistance('SELECT id, source, target, cost FROM road_network_mins',(
    SELECT tc_nn.node
    FROM tc_nn), 10000000) dist, nodes
WHERE dist.node = nodes.node AND agg_cost < 10) AS pt
```

### Create a "5 minutes to 55 mph" polygon

Sometimes you aren't interested in the drive times from a single point, but instead from a line or a polygon feature. One situation where this occurs is determining how long it takes someone from any given location to access a highway. This query is similar to the previous one with the exception that we will now be using multiple input start nodes. For this reason, it is not uncommon to have these queries crash during runtime. I suggest clipping down your scale to the city or perhaps county level for the road network and manually merging the outputs if you require a metro-scale vector.

#### 1. Filter the road network to a smaller area of interest (Minneapolis)
```sql
CREATE VIEW road_network_mins_mpls AS(
  SELECT *
  FROM road_network_mins, (
    SELECT *
    FROM ctu
    WHERE ctu.name = 'Minneapolis') AS mpls
  WHERE ST_Intersects(road_network_mins.geom_way, mpls.geom) = TRUE);
```

#### 2. Select all nodes with a speed limit of 55 miles (~85 kmh) per hour or over
```sql
CREATE VIEW mpls_hwy_nodes AS(
 SELECT source AS node,
    st_startpoint(geom) AS geom
   FROM road_network_mins_mpls
   WHERE kmh > 85
UNION
 SELECT target AS node,
    st_endpoint(geom) AS geom
   FROM road_network_mins_mpls
   WHERE kmh > 85);
```

#### 3. Create a table of all nodes in the network to use for the concave hull
```sql
CREATE VIEW mpls_nodes AS(
 SELECT source AS node,
    st_startpoint(geom) as geom
   FROM road_network_mins_mpls
UNION
 SELECT target AS node,
    st_endpoint(geom) as geom
   FROM road_network_mins_mpls);
```

#### 4. Create a concave hull of all nodes reachable from all possible highway nodes in Minneapolis within 5 minutes

Note: You may use either `array_agg` or `Array` to send multiple nodes to the `PGR_DrivingDistance` function
```sql
SELECT ST_ConcaveHull(ST_Collect(pts.geom),.75, true)
FROM (
  SELECT dist.seq, dist.node, dist.edge, dist.cost, dist.agg_cost, mpls_nodes.geom
  FROM PGR_DrivingDistance('SELECT id, source, target, cost FROM road_network_mins_mpls',(
    SELECT array_agg(mpls_hwy_nodes.node) as node
    FROM mpls_hwy_nodes), 10000000) dist, mpls_nodes
WHERE dist.node = mpls_nodes.node AND agg_cost < 5) AS pts;
```

