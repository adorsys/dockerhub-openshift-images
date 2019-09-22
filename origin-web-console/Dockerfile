ARG OKD_VERSION=v3.11.0

FROM centos AS RPM

ARG WEBCONSOLE_VERSION=3.11.141-1.git.1.54aa706

RUN curl -sfLJO http://ftp.redhat.com/redhat/linux/enterprise/7Server/en/RHOSE/SRPMS/atomic-openshift-web-console-${WEBCONSOLE_VERSION}.el7.src.rpm

RUN yum groupinstall -y 'Development Tools'
RUN yum install -y rpm-build epel-release which
RUN yum-builddep -y atomic-openshift-web-console-*.el7.src.rpm

RUN rpmbuild --rebuild atomic-openshift-web-console-*.el7.src.rpm

FROM openshift/origin-web-console:${OKD_VERSION}

COPY --from=RPM /root/rpmbuild/RPMS/x86_64/atomic-openshift-web-console-*.rpm /tmp/

USER 0

RUN yum remove origin-web-console -y \
    && yum localinstall -y /tmp/*.rpm \
    && rm -f /tmp/*.rpm

USER 1001
