ARG OKD_VERSION=v3.11.0

FROM openshift/origin-haproxy-router:${OKD_VERSION} AS PATCH

USER 0

RUN yum install -y patch
COPY patches /tmp/

# https://github.com/openshift/origin/pull/19840
RUN for patch in /tmp/*.patch; do echo $patch; patch -u -l -f /var/lib/haproxy/conf/haproxy-config.template "${patch}"; done

FROM openshift/origin-haproxy-router:${OKD_VERSION}

ARG HAPROXY_VERSION=1.8.17-3

COPY --from=PATCH /var/lib/haproxy/conf/haproxy-config.template /var/lib/haproxy/conf/haproxy-config.template

USER 0

RUN yum localinstall -y https://cbs.centos.org/repos/paas7-openshift-origin311-testing/x86_64/os/Packages/haproxy18-${HAPROXY_VERSION}.el7.x86_64.rpm && rm -f tmp/haproxy18*.rpm \
    && setcap 'cap_net_bind_service=ep' /usr/sbin/haproxy

USER 1001
