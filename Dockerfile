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

# zap工具
# zap-v2023.04.27-nightly
COPY zap-linux.zip /opt/
RUN set -x \
    && cd /opt \
    && unzip zap-linux.zip -d zap-v2023.04.27-nightly \
    && echo "export PATH=$PATH:/opt/zap-v2023.04.27-nightly" >> ~/.bashrc \
    && : # last line
ENV ZAP_INSTALL_PATH /opt/zap-v2023.04.27-nightly

SHELL ["/bin/bash", "-c"]

RUN set -x \
    && cd /opt/connectedhomeip \
    && source scripts/bootstrap.sh \
    && source scripts/activate.sh \
    && gn gen out \
    && ninja -C out src/lib:lib \
    && : # last line
