FROM postgres:10
LABEL maintainer = "Dylan J. Richardson" <dylanjackrichardson@gmail.com>

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-10-postgis-2.4 \
           postgresql-10-postgis-2.4-scripts \
           postgis-2.4\
           postgresql-10-pgrouting\
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./postgis.sh /docker-entrypoint-initdb.d/postgis.sh
COPY ./data /usr/local/bin/data
RUN gunzip /usr/local/bin/data/osm_point
RUN gunzip /usr/local/bin/data/osm_line
RUN gunzip /usr/local/bin/data/osm_polygon
RUN gunzip /usr/local/bin/data/osm_roads
RUN gunzip /usr/local/bin/data/road_network
RUN mv /usr/local/bin/data/osm_point /usr/local/bin/data/osm_point.sql
RUN mv /usr/local/bin/data/osm_line /usr/local/bin/data/osm_line.sql
RUN mv /usr/local/bin/data/osm_polygon /usr/local/bin/data/osm_polygon.sql
RUN mv /usr/local/bin/data/osm_roads /usr/local/bin/data/osm_roads.sql
RUN mv /usr/local/bin/data/road_network /usr/local/bin/data/road_network.sql
