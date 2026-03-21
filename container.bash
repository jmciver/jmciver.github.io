#!/usr/bin/bash

set -u

declare -r SCRIPT_NAME=$(basename "$0")
declare -r SCRIPT_PATH=$(realpath ${0%/*})
declare -r BASE_DIRCTORY_NAME=$(basename "$SCRIPT_PATH")

declare -r USER_ID=$(id -u)
declare -r GROUP_ID=$(id -g)

declare -r IMAGE_NAME="jekyll-local:latest"

declare -r WORK_DIR="/work/$BASE_DIRCTORY_NAME"

docker image inspect "$IMAGE_NAME" &> /dev/null
[[ $? -ne 0 ]] && docker build --tag="${IMAGE_NAME}" .

[[ ! -d "$SCRIPT_PATH/gems" ]] && mkdir -p "$SCRIPT_PATH/gems"

docker run \
  -it \
  --rm \
  --user "${USER_ID}:${GROUP_ID}" \
  -v $SCRIPT_PATH:$WORK_DIR \
  -v $SCRIPT_PATH/gems:/home/jekyll/gems \
  -p 4000:4000 \
  "$IMAGE_NAME" \
  /usr/bin/bash
