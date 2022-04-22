ARG BASE_IMAGE_JUMANPP=ubuntu:latest
ARG BASE_IMAGE_KNP=ubuntu:latest

FROM ${BASE_IMAGE_JUMANPP} AS jumanpp
FROM ${BASE_IMAGE_KNP} AS knp

# Configure Japanese locale
RUN apt-get update \
    && apt-get install -y locales \
    && locale-gen ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="en_US" \
    LC_ALL="ja_JP.UTF-8"
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

COPY --from=jumanpp /usr/local /usr/local

CMD /bin/bash
