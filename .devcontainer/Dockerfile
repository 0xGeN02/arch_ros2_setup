# Usa la versión de Ubuntu 22.04
FROM ubuntu:24.04

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

# Instalar ROS2:Rolling
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y curl && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null && \
    apt-get update && \
    apt-get install -y ros-dev-tools ros-rolling-desktop ros-rolling-ros-base && \
    rm -rf /var/lib/apt/lists/*

# Instalar Gazebo Harmonic
RUN apt-get update && \
    apt-get install -y curl lsb-release gnupg && \
    curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null && \
    apt-get update && \
    apt-get install -y gz-harmonic && \
    rm -rf /var/lib/apt/lists/*

# Configura el entorno de ROS 2
RUN echo "source /opt/ros/rolling/setup.bash" >> /etc/bash.bashrc

# Argumentos para el nombre de usuario y UID/GID
ARG USERNAME
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