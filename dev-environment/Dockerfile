# syntax=docker/dockerfile:1

# DO NOT COPY the gateway codebase into the Docker image.

ARG GATEWAY_DOCKER_IMG

FROM ${GATEWAY_DOCKER_IMG}

ENV DEBIAN_FRONTEND="noninteractive" 

USER root

# Puppeter dependencies
RUN \
  apt-get -y install \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon-x11-0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    libxshmfence1

USER deploy
