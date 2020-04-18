#!/usr/bin/env bash

HAPROXY_VERSION=$(grep HAPROXY_PATCH_VERSION= "$(git rev-parse --show-toplevel)"/origin-haproxy-router/adorsys/Dockerfile | cut -d= -f2)

docker run --rm --entrypoint=/usr/sbin/haproxy "${DOCKER_IMAGE}:${TAG}" -vv
docker run --rm --entrypoint=/bin/bash "${DOCKER_IMAGE}:${TAG}" -c "haproxy -v | grep '${HAPROXY_VERSION}'"
docker run --rm --entrypoint=/bin/bash "${DOCKER_IMAGE}:${TAG}" -c "haproxy -vv | grep 'TLSv1.3'"
