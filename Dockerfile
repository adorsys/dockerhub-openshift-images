FROM centos AS RPM

ARG HAPROXY_VERSION=1.8.14-2

RUN curl -sfLJO http://ftp.redhat.com/redhat/linux/enterprise/7Server/en/RHOSE/SRPMS/haproxy-${HAPROXY_VERSION}.el7.src.rpm

RUN yum groupinstall -y 'Development Tools'
RUN yum install -y rpm-build
RUN yum-builddep -y haproxy-*.el7.src.rpm

RUN rpmbuild --rebuild haproxy-*.el7.src.rpm

FROM openshift/origin-haproxy-router:v3.11.0

COPY --from=RPM /root/rpmbuild/RPMS/x86_64/haproxy18*.rpm /tmp/

USER 0

RUN yum localinstall -y /tmp/haproxy18*.rpm && rm -f tmp/haproxy18*.rpm

USER 1001
