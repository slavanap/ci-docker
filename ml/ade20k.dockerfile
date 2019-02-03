FROM ubuntu:bionic as download

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -qqy --no-install-recommends ca-certificates wget unzip \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir /data && cd /data \
 && wget --progress=dot -e dotbytes=100M http://groups.csail.mit.edu/vision/datasets/ADE20K/ADE20K_2016_07_26.zip \
     && unzip -q ADE20K_2016_07_26.zip && rm ADE20K_2016_07_26.zip

#FROM scratch #ubuntu:bionic
#COPY --from=download /ADE20K_2016_07_26 /data/ADE20K_2016_07_26
