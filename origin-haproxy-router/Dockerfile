ARG OKD_VERSION=v3.11.0

FROM centos:7 AS RPM

ARG HAPROXY_VERSION=1.8.17-3

RUN curl -sfLJO http://ftp.redhat.com/redhat/linux/enterprise/7Server/en/RHOSE/SRPMS/haproxy-${HAPROXY_VERSION}.el7.src.rpm

RUN yum groupinstall -y 'Development Tools'
RUN yum install -y rpm-build
RUN yum-builddep -y haproxy-*.el7.src.rpm

RUN rpmbuild --rebuild haproxy-*.el7.src.rpm


FROM openshift/origin-haproxy-router:${OKD_VERSION} AS PATCH

USER 0

RUN yum install -y patch
COPY patches /tmp/

# https://github.com/openshift/origin/pull/19840
RUN for patch in /tmp/*.patch; do echo $patch; patch /var/lib/haproxy/conf/haproxy-config.template "${patch}"; done

FROM openshift/origin-haproxy-router:${OKD_VERSION}

COPY --from=RPM /root/rpmbuild/RPMS/x86_64/haproxy18*.rpm /tmp/
COPY --from=PATCH /var/lib/haproxy/conf/haproxy-config.template /var/lib/haproxy/conf/haproxy-config.template

USER 0

RUN yum localinstall -y /tmp/haproxy18*.rpm && rm -f tmp/haproxy18*.rpm \
    && setcap 'cap_net_bind_service=ep' /usr/sbin/haproxy

USER 1001
