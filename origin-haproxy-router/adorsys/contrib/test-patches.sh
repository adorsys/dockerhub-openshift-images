#!/bin/bash

docker run -u0 --entrypoint=/bin/bash -v "$(git rev-parse --show-toplevel)/origin-haproxy-router/adorsys/patches:/patches" --rm openshift/origin-haproxy-router:v3.11.0 \
  -c "set -e; yum install -q -y patch; for patch in /patches/*.patch; do echo \$patch; patch -u -l -f /var/lib/haproxy/conf/haproxy-config.template \"\${patch}\"; done"
