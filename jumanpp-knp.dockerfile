ARG BASE_IMAGE_JUMANPP=jumanpp:latest
ARG BASE_IMAGE=ubuntu:latest

FROM ${BASE_IMAGE_JUMANPP} AS builder
WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update -q && apt-get install -yq --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    make \
    wget \
    ca-certificates \
    zlib1g-dev \
    libtool \
    automake \
    autoconf \
    unzip \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Build and install KNP
RUN git clone --depth 1 https://github.com/ku-nlp/knp.git
WORKDIR /app/knp
RUN ./autogen.sh
RUN wget -q "http://lotus.kuee.kyoto-u.ac.jp/nl-resource/knp/dict/latest/knp-dict-latest-bin.zip" \
    && unzip knp-dict-latest-bin.zip \
    && rm -f knp-dict-latest-bin.zip \
    && cp -ars "$(pwd)"/dict-bin/* ./dict \
    && ./configure \
    && make -j "$([ "$(nproc)" -le 8 ] && nproc || echo "8")" \
    && make install

FROM ${BASE_IMAGE} AS runner

# Configure Japanese locale
RUN apt-get update -q && apt-get install -yq --no-install-recommends \
    locales \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="en_US" \
    LC_ALL="ja_JP.UTF-8"
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

COPY --from=builder /usr/local /usr/local

CMD ["/bin/bash"]
