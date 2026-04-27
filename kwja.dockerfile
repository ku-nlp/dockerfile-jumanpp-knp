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
    build-essential \
    ca-certificates \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN /root/.local/bin/uv tool install --no-cache kwja=="${KWJA_VERSION}" --python 3.13

ENV PATH="/root/.local/bin:${PATH}"

CMD ["/bin/bash"]
