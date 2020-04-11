#!/usr/bin/env bash

docker run --rm --entrypoint=/usr/sbin/haproxy "${DOCKER_IMAGE}:${TAG}" -vv
docker run --rm --entrypoint=/bin/bash "${DOCKER_IMAGE}:${TAG}" -c "haproxy -v | grep '2.0.14'"
docker run --rm --entrypoint=/bin/bash "${DOCKER_IMAGE}:${TAG}" -c "haproxy -vv | grep 'TLSv1.3'"
