#!/bin/bash

docker run --entrypoint=/bin/cat --rm -ti adorsys/origin-haproxy-router:v3.11.0-adorsys /var/lib/haproxy/conf/haproxy-config-adorsys.template > haproxy-config.template
