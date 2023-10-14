ARG BASE_IMAGE=ubuntu:latest
FROM ${BASE_IMAGE}
ARG KWJA_VERSION
WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive

# Configure Japanese locale
RUN apt-get update -q && apt-get install -yq \
    locales \
    && locale-gen ja_JP.UTF-8 \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="en_US" \
    LC_ALL="ja_JP.UTF-8"
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

RUN apt-get update -q && apt-get install -yq --no-install-recommends \
    wget \
    build-essential \
    ca-certificates \
    python3-venv \
    python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip --no-cache-dir \
    && pip3 install --no-cache-dir kwja==${KWJA_VERSION}

# pre-download models
# RUN kwja --text 'こんにちは'

CMD ["/bin/bash"]
