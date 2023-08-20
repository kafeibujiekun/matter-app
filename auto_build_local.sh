#!/bin/bash

CONTAINER_NAME="chip-app-build"
SOURCE_DIR="$PWD/light"
CONTAINER_DIR="/home/light"

docker run --rm -it -d --name ${CONTAINER_NAME} --mount source=${SOURCE_DIR},target=${CONTAINER_DIR},type=bind chip-build-env:1.0
docker exec -it ${CONTAINER_NAME} bash -c "cd /home/light && bash build.sh"
docker cp ${CONTAINER_NAME}:/home/light/out/chip-lighting-app ./
docker stop ${CONTAINER_NAME}
