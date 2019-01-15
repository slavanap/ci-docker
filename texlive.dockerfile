FROM ubuntu:bionic

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive ROS_DISTRO="$ROS_DISTRO"
RUN apt-get update -qq && apt-get install -qqy --no-install-recommends texlive-full

WORKDIR /opt
