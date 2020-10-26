# MIT license
# Copyright (c) 2019 Vyacheslav Napadovsky 

FROM osgeo/gdal:alpine-ultrasmall-latest as tz_world

WORKDIR /src

RUN wget -nv http://efele.net/maps/tz/world/tz_world.zip \
 && unzip -q tz_world.zip \
 && rm tz_world.zip

RUN apk --no-cache add jq \
 && cd /src/world \
 && ogr2ogr -f GeoJSON -t_srs crs:84 tz_world_tmp.geojson tz_world.shp \
 && jq ".features = (.features | map(.properties.tzid = .properties.TZID))" tz_world_tmp.geojson > tz_world.geojson \
 && rm tz_world_tmp.geojson
