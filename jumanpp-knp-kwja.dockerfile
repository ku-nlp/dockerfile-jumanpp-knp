ARG BASE_IMAGE_JUMANPP=jumanpp:latest
ARG BASE_IMAGE_KNP=knp:latest
ARG BASE_IMAGE_KWJA=kwja:latest

FROM ${BASE_IMAGE_JUMANPP} AS jumanpp
FROM ${BASE_IMAGE_KNP} AS knp
FROM ${BASE_IMAGE_KWJA}

# Configure Japanese locale
RUN apt-get update -q && apt-get install -yq --no-install-recommends \
    locales \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="en_US" \
    LC_ALL="ja_JP.UTF-8"
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

COPY --from=jumanpp /usr/local /usr/local
COPY --from=knp /usr/local /usr/local

CMD ["/bin/bash"]
