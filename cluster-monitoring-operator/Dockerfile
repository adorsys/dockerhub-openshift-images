FROM centos:7

ENV GOPATH /go
ENV PATH="${PATH}:${GOPATH}/bin"
RUN mkdir $GOPATH

WORKDIR $GOPATH/src/github.com/openshift/cluster-monitoring-operator

RUN curl -sSfL https://github.com/openshift/cluster-monitoring-operator/archive/release-3.11.tar.gz \
    | tar xz -C $GOPATH/src/github.com/openshift/cluster-monitoring-operator --strip-components 1

RUN yum install -y epel-release && \
    yum install -y golang make git && \
    cd $GOPATH/src/github.com/openshift/cluster-monitoring-operator && \
    make operator-no-deps && cp $GOPATH/src/github.com/openshift/cluster-monitoring-operator/operator /usr/bin/ && \
    yum erase -y golang make git && yum clean all

LABEL io.k8s.display-name="OpenShift cluster-monitoring-operator" \
      io.k8s.description="This is a component of OpenShift Container Platform and manages the lifecycle of the Prometheus based cluster monitoring stack." \
      io.openshift.tags="openshift" \
      maintainer="Frederic Branczyk <fbranczy@redhat.com>"

# doesn't require a root user.
USER 1001

ENTRYPOINT ["/usr/bin/operator"]
