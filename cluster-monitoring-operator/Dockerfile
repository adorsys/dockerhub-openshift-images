FROM golang:1.10 AS builder
WORKDIR /go/src/github.com/openshift/cluster-monitoring-operator/

RUN git clone --depth=1 --branch release-3.11 https://github.com/openshift/cluster-monitoring-operator.git .
RUN make dependencies build

FROM openshift/origin-base:v3.11

ENV GOPATH /go
ENV PATH="${PATH}:${GOPATH}/bin"
RUN mkdir $GOPATH

COPY --from=builder /go/src/github.com/openshift/cluster-monitoring-operator/operator /usr/bin/operator

LABEL io.k8s.display-name="OpenShift cluster-monitoring-operator" \
      io.k8s.description="This is a component of OpenShift Container Platform and manages the lifecycle of the Prometheus based cluster monitoring stack." \
      io.openshift.tags="openshift" \
      maintainer="Frederic Branczyk <fbranczy@redhat.com>"

# doesn't require a root user.
USER 1001

ENTRYPOINT ["/usr/bin/operator"]
