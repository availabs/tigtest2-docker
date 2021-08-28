# syntax=docker/dockerfile:1

# Ubuntu 18.04 is required to install Ruby 2.2.0
#   because of dependency on libssl1.0-dev

FROM ubuntu:18.04

ENV DEBIAN_FRONTEND="noninteractive" 

RUN apt-get update
RUN apt-get -y upgrade

RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

# Install the first set of system dependencies
RUN apt-get -y install \
    curl \
    git \
    gpg \
    libpq-dev \
    software-properties-common \
    tzdata

# Configure the TimeZone data
# https://stackoverflow.com/a/44333806/3970755
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Install the GIS system dependencies
RUN add-apt-repository ppa:ubuntugis/ppa
RUN apt-get update
RUN apt-get -y install \
   gdal-bin \
   libgeos-dev \
   libproj-dev

# Install the Ruby 2.0.0 dependencies so deploy user won't need sudo.
RUN \
  apt-get -y install \
    autoconf \
    automake \
    bison \
    g++ \
    gawk \
    gcc \
    libc6-dev \
    libffi-dev \
    libgdbm-dev \
    libgmp-dev \
    libncurses5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl1.0-dev \
    libtool \
    libyaml-dev \
    make \
    pkg-config \
    sqlite3 \
    zlib1g-dev

# Install Node v14
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Create the deploy user
RUN useradd \
  -d /home/deploy \
  -m deploy \
  -s /bin/bash

# Change to deploy user
USER deploy
WORKDIR /home/deploy/

# Install RVM
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
RUN curl -sSL https://get.rvm.io | bash -s stable

# Note: '/bin/bash -l -c' makes available rvm modifcations to ~/.bashrc
RUN /bin/bash -l -c "rvm install 2.2.0"
RUN /bin/bash -l -c "rvm --force rubygems 2.7.7"
RUN /bin/bash -l -c "gem install bundler -v 1.17.3"

COPY ./container_scripts/get-gateway /home/deploy/get-gateway
COPY ./container_scripts/init-gateway /home/deploy/init-gateway
COPY ./container_scripts/deploy-gateway /home/deploy/deploy-gateway
