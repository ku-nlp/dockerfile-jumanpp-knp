FROM python:3.11-slim-bullseye
ARG KWJA_VERSION
WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -q && apt-get install -yq --no-install-recommends \
    build-essential \
    pipx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pipx install --pip-args="--no-cache-dir" kwja=="${KWJA_VERSION}" \
    && rm -rf /root/.cache

ENV PATH="/root/.local/bin:${PATH}"

CMD ["/bin/bash"]
