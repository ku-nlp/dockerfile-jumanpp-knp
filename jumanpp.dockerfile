ARG BASE_IMAGE=ubuntu:latest
FROM ${BASE_IMAGE} AS builder
# ARG should be placed after FROM
ARG JPP_VERSION=2.0.0-rc4
WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update -q && apt-get install -yq --no-install-recommends \
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
RUN wget "https://github.com/ku-nlp/jumanpp/releases/download/v${JPP_VERSION}/jumanpp-${JPP_VERSION}.tar.xz" -qO - \
    | tar Jxf - \
    && mkdir "jumanpp-${JPP_VERSION}/bld" \
    && cd "jumanpp-${JPP_VERSION}/bld" \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
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
