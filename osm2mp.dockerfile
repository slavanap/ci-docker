# also tested with debian:stretch and ubuntu:xenial
ARG image_source=ubuntu:bionic
FROM $image_source

LABEL maintainer "Vyacheslav Napadovsky" <napadovskiy@gmail.com>
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive

# optional packages: libencode-locale-perl libinline-perl
RUN apt-get -qq update && apt-get install -qqy --no-install-recommends \
    libconfig-std-perl libjson-perl liblist-moreutils-perl libmath-polygon-perl \
    libtemplate-perl libtext-unidecode-perl libxml-parser-perl libyaml-perl \
    libencode-locale-perl libinline-perl \
    build-essential cpanminus git wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
# essential packages: only first line
RUN cpanm --local-lib cpan \
    File::Slurp Geo::Openstreetmap::Parser Math::Polygon::Tree Tree::R match::smart \
    Data::Dump Geo::Shapefile::Writer Getopt::Long Log::Any Log::Any::Adapter PerlIO::encoding PerlIO::via::PrepareCP1251 PerlIO::via::Unidecode \
    Carp FindBin List::Util LWP::UserAgent Math::Clipper Math::Geometry::Planar::GPC::PolygonXS
ENV PERL5LIB=/opt/cpan/lib/perl5

RUN git clone https://github.com/liosha/osm2mp

# Simple test
RUN wget --progress=dot -e dotbytes=100k https://api.openstreetmap.org/api/0.6/map?bbox=11.54,48.14,11.543,48.145 -O map.osm && \
    osm2mp/osm2mp.pl map.osm > /dev/null && \
    rm map.osm
