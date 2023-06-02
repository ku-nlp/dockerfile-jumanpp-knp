ARG BASE_IMAGE=ubuntu:latest
FROM ${BASE_IMAGE}
ARG KWJA_VERSION
ARG PYTHON_VERSION=3.11.3
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

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    build-essential \
    libbz2-dev \
    libffi-dev \
    libgdbm-dev \
    libgdbm-compat-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    lzma \
    lzma-dev \
    tk-dev \
    uuid-dev \
    zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python
RUN wget --no-check-certificate -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz" \
    && mkdir -p /usr/src/python \
    && tar --extract --directory /usr/src/python --strip-components=1 --file python.tar.xz \
    && rm python.tar.xz \
    && cd /usr/src/python \
    && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
    && ./configure --build="$gnuArch" --enable-loadable-sqlite-extensions --enable-optimizations --enable-option-checking=fatal --enable-shared --with-lto --with-system-expat \
    && make -j "$(nproc)" LDFLAGS="-Wl,--strip-all" \
    && make install \
    && rm -rf /usr/src/python \
    && ldconfig \
    && python3 --version \
    && apt-get autoremove -y

# # Install pip
# RUN wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py \
#     && env PYTHONDONTWRITEBYTECODE=1 python3 get-pip.py --no-cache-dir \
#     && rm -f get-pip.py \
#     && pip --version

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip --no-cache-dir \
    && pip3 install --no-cache-dir kwja==${KWJA_VERSION}

# pre-download models
# RUN kwja --text 'こんにちは'

CMD /bin/bash
