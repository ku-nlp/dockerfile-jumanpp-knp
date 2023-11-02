ARG BASE_IMAGE_JUMANPP_KNP=jumanpp-knp:latest
ARG BASE_IMAGE_KWJA=kwja:latest

FROM ${BASE_IMAGE_JUMANPP_KNP} AS jumanpp-knp
FROM ${BASE_IMAGE_KWJA}

COPY --from=jumanpp-knp /usr/local /usr/local

CMD ["/bin/bash"]
