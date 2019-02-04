FROM ubuntu:bionic

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -qqy --no-install-recommends \
        build-essential python python-pip python-setuptools python-dev libsm6 libxrender1 libxext6 libglib2.0-0 \
        git ca-certificates \
 && pip install wheel \
 && git clone https://github.com/ISSResearch/Dataset-Converters /opt && cd /opt \
 && git checkout d5b88b0bd6c4f896e492d304c9c73b9d2ff5167a && rm -rf .git \
 && pip install -r requirements.txt

WORKDIR /opt
ENTRYPOINT ["/usr/bin/python", "convert.py"]
