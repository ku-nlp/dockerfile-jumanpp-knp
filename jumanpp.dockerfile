ARG BASE_IMAGE=ubuntu:latest
FROM ${BASE_IMAGE} AS builder
WORKDIR /app
ENV DEBIAN_FRONTEND noninteractive
ARG JPP_VERSION=2.0.0-rc3

RUN apt-get -q update && apt-get install -yq --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    libprotobuf-dev \
    wget \
    curl \
    ca-certificates

# Build and install Juman++
RUN wget https://github.com/ku-nlp/jumanpp/releases/download/v${JPP_VERSION}/jumanpp-${JPP_VERSION}.tar.xz -qO - \
    | tar Jxf - \
    && cd jumanpp-${JPP_VERSION} \
    && mkdir bld \
    && cd bld \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
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
