FROM ubuntu:bionic

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -qqy --no-install-recommends ca-certificates wget unzip \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir /data && cd /data \
 && wget --progress=dot -e dotbytes=500M http://images.cocodataset.org/zips/val2014.zip \
     && unzip -q val2014.zip && rm val2014.zip \
 && wget --progress=dot -e dotbytes=500M http://images.cocodataset.org/annotations/annotations_trainval2014.zip \
     && unzip -q annotations_trainval2014.zip && rm annotations_trainval2014.zip \
     && rm annotations/*_train*.json
