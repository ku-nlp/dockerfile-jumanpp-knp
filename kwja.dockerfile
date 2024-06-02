ARG BASE_IMAGE=ubuntu:latest
FROM ${BASE_IMAGE}
ARG KWJA_VERSION
WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive

# Configure Japanese locale
RUN apt-get update -q && apt-get install -yq --no-install-recommends \
    locales \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="en_US" \
    LC_ALL="ja_JP.UTF-8"
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

RUN apt-get update -q && apt-get install -yq --no-install-recommends \
    wget \
    build-essential \
    ca-certificates \
    python3-dev \
    python3-pip \
    python3-venv \
    pipx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pipx install --pip-args="--no-cache-dir" kwja=="${KWJA_VERSION}" \
    && rm -rf /root/.cache

ENV PATH="/root/.local/bin:${PATH}"

CMD ["/bin/bash"]
