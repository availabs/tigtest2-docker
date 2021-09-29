# syntax=docker/dockerfile:1

# DO NOT COPY the gateway codebase into the Docker image.

FROM debian:10.10

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
