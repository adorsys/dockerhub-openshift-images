ARG OKD_VERSION=v3.11.0

ARG IMAGE_NAME=origin-docker-registry
ARG RPM_NAME=atomic-openshift-dockerregistry
ARG RPM_VERSION=3.11.286-1.git.1.11d835a

FROM openshift/${IMAGE_NAME}:${OKD_VERSION} AS RPM

ARG RPM_NAME
ARG RPM_VERSION

USER 0

RUN curl -sfLJO https://ftp.redhat.com/redhat/linux/enterprise/7Server/en/RHOSE/SRPMS/${RPM_NAME}-${RPM_VERSION}.el7.src.rpm

RUN yum groupinstall -y 'Development Tools'
RUN yum install -y rpm-build epel-release which yum-utils
RUN yum-builddep -y ${RPM_NAME}-${RPM_VERSION}.el7.src.rpm

RUN rpmbuild --rebuild ${RPM_NAME}-${RPM_VERSION}.el7.src.rpm

FROM openshift/${IMAGE_NAME}:${OKD_VERSION}

ARG RPM_NAME
ARG RPM_VERSION

COPY --from=RPM /root/rpmbuild/RPMS/x86_64/${RPM_NAME}-${RPM_VERSION}.el7.x86_64.rpm /tmp/

USER 0

RUN yum remove origin-dockerregistry -y \
    && yum localinstall -y /tmp/${RPM_NAME}-${RPM_VERSION}.el7.x86_64.rpm && rm -f /tmp/${RPM_NAME}-${RPM_VERSION}.el7.x86_64.rpm

USER 1001
