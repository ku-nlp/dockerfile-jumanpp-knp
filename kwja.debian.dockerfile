FROM debian:trixie-slim
ARG KWJA_VERSION
WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive

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
