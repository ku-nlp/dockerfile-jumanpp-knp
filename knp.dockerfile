ARG BASE_IMAGE=ubuntu:latest
FROM ${BASE_IMAGE} AS builder
WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -q && apt-get install -yq --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    make \
    wget \
    curl \
    ca-certificates \
    zlib1g-dev \
    libtool \
    automake \
    autoconf \
    git \
    unzip

# Build and install KNP
RUN git clone --depth 1 https://github.com/ku-nlp/knp.git \
    && cd knp \
    && ./autogen.sh \
    && wget -q http://lotus.kuee.kyoto-u.ac.jp/nl-resource/knp/dict/latest/knp-dict-latest-bin.zip \
    && unzip knp-dict-latest-bin.zip \
    && rm -f knp-dict-latest-bin.zip \
    && cp -ars $(pwd)/dict-bin/* ./dict \
    && ./configure \
    && make -j $([ $(nproc) -le 8 ] && echo "$(nproc)" || echo "8") \
    && make install

FROM ${BASE_IMAGE} AS runner

# Configure Japanese locale
RUN apt-get update \
    && apt-get install -y locales \
    && locale-gen ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="en_US" \
    LC_ALL="ja_JP.UTF-8"
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

COPY --from=builder /usr/local /usr/local

CMD /bin/bash
