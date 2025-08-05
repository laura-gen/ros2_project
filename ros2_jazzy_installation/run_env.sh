#!/bin/bash

IMAGE_NAME="ros2_jazzy_ubuntu24"

# Build si l'image n'existe pas ou après modification du Dockerfile
if ! docker image inspect $IMAGE_NAME > /dev/null 2>&1; then
    echo " Construction de l'image Docker"
    docker build -t ${IMAGE_NAME}:1.0.0 -t ${IMAGE_NAME}:latest .

fi

# Lancer le conteneur avec montage du workspace pour une sychronisation entre le workspace du conteneur et celui du PC
echo "Lancement de l'environnement ROS2 Jazzy"
docker run -it --rm \
    --name ros2_container \
    -p 50002:50002 \
    --add-host ur3e:192.168.1.101 \
    -v "$(pwd)/../ros2_ws:/root/ros2_ws" \
    ${IMAGE_NAME}:latest

