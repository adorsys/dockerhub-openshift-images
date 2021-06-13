#!/usr/bin/env bash

docker run --rm --entrypoint=/usr/sbin/haproxy "${DOCKER_IMAGE}:${TAG}" -vv
docker run --rm --entrypoint=/bin/bash "${DOCKER_IMAGE}:${TAG}" -c "haproxy -v | grep '1.8.'"
