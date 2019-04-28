# at least 7GB of RAM to build, 3h on 2-core Intel i7 CPU.

FROM osrm/osrm-backend:latest-assertions

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends wget ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir /data && cd /data \
 && wget -nv "https://download.geofabrik.de/north-america/us-northeast-latest.osm.bz2"

RUN osrm-extract -p /opt/car.lua /data/us-northeast-latest.osm.bz2 \
 && osrm-partition /data/us-northeast-latest.osrm \
 && osrm-customize /data/us-northeast-latest.osrm

CMD ["/usr/local/bin/osrm-routed", "--algorithm", "mld", "/data/us-northeast-latest.osrm"]
