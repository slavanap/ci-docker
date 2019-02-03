FROM ubuntu:bionic

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -qqy --no-install-recommends ca-certificates wget unzip \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir /data && cd /data \
 && wget --progress=dot -e dotbytes=500M http://images.cocodataset.org/zips/test2014.zip \
     && unzip -q test2014.zip && rm test2014.zip \
 && wget --progress=dot -e dotbytes=500M http://images.cocodataset.org/annotations/image_info_test2014.zip \
     && unzip -q image_info_test2014.zip && rm image_info_test2014.zip
