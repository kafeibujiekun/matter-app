FROM ubuntu:22.04

COPY connectedhomeip /opt/connectedhomeip

RUN set -x \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -fy --fix-missing \
    autoconf \
    automake \
    curl \
    git gcc g++ pkg-config libssl-dev libdbus-1-dev \
    libglib2.0-dev libavahi-client-dev ninja-build python3-venv python3-dev \
    python3-pip unzip libgirepository1.0-dev libcairo2-dev libreadline-dev vim \
    && : # last line

SHELL ["/bin/bash", "-c"]

RUN set -x \
    && cd /opt/connectedhomeip \
    && source scripts/bootstrap.sh \
    && source scripts/activate.sh \
    && gn gen out \
    && ninja -C out src/lib:lib \
    && : # last line
