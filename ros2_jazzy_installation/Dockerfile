  # Dockerfile pour ROS2 Jazzy Jalisco sur Ubuntu 24.04
FROM ubuntu:24.04

# Définit la locale en_US.UTF-8
RUN apt-get update && apt-get install -y locales \
    && locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Installe les outils pour ajouter des dépôts
RUN apt-get install -y software-properties-common curl

# Active le dépôt universe d'Ubuntu
RUN add-apt-repository universe

# Installe automatiquement le dépôt APT de ROS2 depuis GitHub

RUN ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}') \
    && curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" \
    && dpkg -i /tmp/ros2-apt-source.deb

# Installe ros-dev-tools (outils de développement ROS)
RUN apt-get update && apt-get install -y ros-dev-tools

# Installe ROS2 Jazzy Jalisco Desktop et ROS-Base
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y ros-jazzy-desktop ros-jazzy-ros-base

# Installe ur_robot_driver
RUN apt-get install -y ros-jazzy-ur

# Installe ros2_control et ses contrôleurs
RUN apt-get install -y ros-jazzy-ros2-control ros-jazzy-ros2-controllers

# Source automatiquement ROS2 pour chaque nouveau terminal 
RUN echo "source /opt/ros/jazzy/setup.bash" >> /root/.bashrc

# Défini le workspace de travail
WORKDIR /root/ros2_ws

# Source automatiquement le workspace pour chaque nouveau terminal
RUN echo "source /root/ros2_ws/install/setup.bash" >> /root/.bashrc

# Par défaut, lance un bash interactif
CMD ["/bin/bash"]
