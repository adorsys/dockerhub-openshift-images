FROM quay.io/coreos/tectonic-console-builder:v16 AS build

RUN mkdir -p /go/src/github.com/openshift/console/
RUN git clone --single-branch --branch release-3.11 https://github.com/openshift/console.git /go/src/github.com/openshift/console/
WORKDIR /go/src/github.com/openshift/console/
RUN ./build.sh

FROM openshift/origin-base:v3.11

COPY --from=build /go/src/github.com/openshift/console/frontend/public/dist /opt/bridge/static
COPY --from=build /go/src/github.com/openshift/console/bin/bridge /opt/bridge/bin/bridge

LABEL io.k8s.display-name="OpenShift Console" \
      io.k8s.description="This is a component of OpenShift Container Platform and provides a web console." \
      io.openshift.tags="openshift" \
      maintainer="Samuel Padgett <spadgett@redhat.com>"

# doesn't require a root user.
USER 1001

CMD [ "/opt/bridge/bin/bridge", "--public-dir=/opt/bridge/static" ]
