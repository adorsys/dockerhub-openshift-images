ARG OKD_VERSION=v3.11.0
ARG HAPROXY_RPM_VERSION=1.8.23
ARG HAPROXY_RPM_RELEASE=3

FROM centos:7 AS RPM

ARG HAPROXY_RPM_VERSION
ARG HAPROXY_RPM_RELEASE

RUN curl -sfLJO https://ftp.redhat.com/redhat/linux/enterprise/7Server/en/RHOSE/SRPMS/haproxy-${HAPROXY_RPM_VERSION}-${HAPROXY_RPM_RELEASE}.el7.src.rpm

RUN yum groupinstall -y 'Development Tools'
RUN yum install -y rpm-build rpmdevtools
RUN yum-builddep -y haproxy-*.el7.src.rpm
RUN rpm -i haproxy-*.el7.src.rpm

WORKDIR /root/rpmbuild/SPECS

RUN rpmbuild -ba haproxy.spec

FROM openshift/origin-haproxy-router:${OKD_VERSION}

COPY --from=RPM /root/rpmbuild/RPMS/x86_64/haproxy18*.rpm /tmp/

USER 0

RUN yum update -y \
    && yum localinstall -y /tmp/haproxy18*.rpm && rm -f tmp/haproxy18*.rpm \
    && setcap 'cap_net_bind_service=ep' /usr/sbin/haproxy

USER 1001
