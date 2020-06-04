#!/bin/bash

IMAGE_PATH=$1
IMAGE_DEFINITION_FILE=${IMAGE_PATH}/image.yml

function get_image_scope () {
  IMAGE_NAME=$(yq r $1 metadata.image_name)
  SCOPE=$(yq r $1 metadata.scope)

  echo "${SCOPE}/${IMAGE_NAME}"
}

function get_image_filename() {
  IMAGE_FILE_NAME=$(yq r $1 metadata.image_file)

  echo "${IMAGE_PATH}/${IMAGE_FILE_NAME}"
}

function build_docker_image() {
  docker build -t $1 -f $2 .
}

IMAGE_SCOPE=$(get_image_scope $IMAGE_DEFINITION_FILE)
IMAGE_FILE=$(get_image_filename $IMAGE_DEFINITION_FILE)

build_docker_image $IMAGE_SCOPE $IMAGE_FILE

