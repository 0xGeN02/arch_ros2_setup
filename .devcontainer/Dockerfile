# Usa la versión de Ubuntu 22.04
FROM ubuntu:22.04

# Variables de entorno
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV SHELL=/bin/bash

# Actualiza los repositorios e instala las utilidades básicas
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        locales \
        curl \
        gnupg2 \
        lsb-release \
        && locale-gen en_US.UTF-8 \
        && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
        && rm -rf /var/lib/apt/lists/*

# Establece el directorio de trabajo
WORKDIR /workspace

# Cambia a un shell interactivo
CMD ["/bin/bash"]
