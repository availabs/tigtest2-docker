# syntax=docker/dockerfile:1

FROM debian:9.13 AS tig-docker-base

ENV DEBIAN_FRONTEND="noninteractive" 

RUN apt-get update \
    && apt-get -y upgrade

RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

# Install the first set of system dependencies
RUN apt-get -y install \
      curl \
      git \
      gpg \
      libgeos-dev \
      libpq-dev \
      libproj-dev \
      software-properties-common \
      ssh \
      tzdata \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs

# Create the deploy user
RUN useradd \
  -d /home/deploy \
  -m deploy \
  -s /bin/bash

# Change to deploy user
USER deploy
WORKDIR /home/deploy/

# Install RVM
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import - \
    && curl -sSL https://rvm.io/pkuczynski.asc | gpg --import - \
    && curl -sSL https://get.rvm.io | bash -s stable

##### Development Build Stage #####
#
# Install Ruby and the gateway dependencies.
#   Populates the ~/.rvm, ~/.gem, and ~/.bundle directories

FROM tig-docker-base AS tig-docker-dev

USER root

RUN apt-get -y install sudo \
    && adduser deploy sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER deploy

RUN mkdir -p /home/deploy/.ssh
RUN mkdir -p /home/deploy/gateway/

WORKDIR /home/deploy/gateway

COPY --chown=deploy ./mount_dirs/gateway/.ruby-version /home/deploy/gateway/.ruby-version

RUN RUBY_VERSION="$( sed -r 's/[^0-9.]//g' .ruby-version )" \
    && /bin/bash -l -c "rvm install $RUBY_VERSION" \
    && /bin/bash -l -c "rvm --force rubygems 2.7.7" \
    && /bin/bash -l -c "gem install bundler -v 1.17.3"

COPY --chown=deploy ./mount_dirs/gateway/Gemfile /home/deploy/gateway/Gemfile
COPY --chown=deploy ./mount_dirs/gateway/Gemfile.lock /home/deploy/gateway/Gemfile.lock
COPY --chown=deploy ./mount_dirs/gateway/.ruby-gemset /home/deploy/gateway/.ruby-gemset
# COPY --chown=deploy ./mount_dirs/gateway/.bundle /home/deploy/gateway/.bundle

# ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache

RUN    /bin/bash -l -c "bundle update bootstrap3-datetimepicker-rails" \
    && /bin/bash -l -c "bundle install --full-index"

# RUN rm -rf /home/deploy/gateway

WORKDIR /home/deploy

COPY ./container_scripts/configure-gateway /home/deploy/configure-gateway
COPY ./container_scripts/deploy-gateway /home/deploy/deploy-gateway

##### Production Build Stage #####
#
# Remove for security purposes, remove sudo access for deploy user.

FROM tig-docker-dev AS tig-docker-prod

USER root

RUN SUDO_FORCE_REMOVE=yes apt-get -y purge sudo

USER deploy

RUN git rev-parse HEAD > /home/deploy/GATEWAY_GIT_HASH
