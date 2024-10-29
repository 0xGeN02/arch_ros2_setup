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
        sudo \
        && locale-gen en_US.UTF-8 \
        && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
        && rm -rf /var/lib/apt/lists/*

# Configura las fuentes de ROS 2
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list' && \
    apt-get update

# Instala ROS 2 rolling
RUN apt-get update && \
    apt-get install -y ros-rolling-desktop && \
    rm -rf /var/lib/apt/lists/*

# Configura el entorno de ROS 2
RUN echo "source /opt/ros/rolling/setup.bash" >> /etc/bash.bashrc

# Argumentos para el nombre de usuario y UID/GID
ARG USERNAME=xgen0
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Elimina el usuario si ya existe en el contenedor
RUN if id -u $USER_UID ; then userdel `id -un $USER_UID` ; fi

# Crea el usuario
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Establece el directorio de trabajo
WORKDIR /workspace

# Cambia al usuario creado
USER $USERNAME

# Cambia a un shell interactivo
CMD ["/bin/bash"]