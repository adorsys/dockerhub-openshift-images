FROM centos:7

STOPSIGNAL SIGKILL

EXPOSE 10514

RUN yum -y install rsyslog && yum clean all && rm -rf /var/cache/yum \
    && rm -rf /etc/rsyslog.d/*

COPY root /

USER 1001

ENTRYPOINT ["/usr/sbin/rsyslogd", "-n", "-i" , "/tmp/rsyslog.pid"]