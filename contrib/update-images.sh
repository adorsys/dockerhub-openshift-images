#!/bin/bash

set -euo pipefail

sedi() {
  if [ "$(uname)" == "Darwin" ]; then
    sed -i "" "$@"
  else
    sed -i "$@"
  fi
}

RH_FTP_OUTPUT="$(curl -sSf https://ftp.redhat.com/redhat/linux/enterprise/7Server/en/RHOSE/SRPMS/)"

REGISTRY_VERSION=$(echo "${RH_FTP_OUTPUT}" | grep -o -E 'atomic-openshift-dockerregistry.*.rpm"' | cut -d- -f4-5 | sed -e 's/.el7.src.rpm"//g' | tail -n1)
sedi "s/ARG RPM_VERSION=.*/ARG RPM_VERSION=${REGISTRY_VERSION}/" origin-docker-registry/Dockerfile

WEB_CONSOLE_VERSION=$(echo "${RH_FTP_OUTPUT}" | grep -o -E 'atomic-openshift-web-console.*.rpm"' | cut -d- -f5-6 | sed -e 's/.el7.src.rpm"//g' | tail -n1)
sedi "s/ARG RPM_VERSION=.*/ARG RPM_VERSION=${WEB_CONSOLE_VERSION}/" origin-web-console/Dockerfile

docker build -t adorsys/origin-docker-registry:v3.11 origin-docker-registry
docker build -t adorsys/origin-web-console:v3.11 origin-web-console
