FROM registry.access.redhat.com/ubi8/ubi:latest AS TZDATA

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

EXPOSE 10514

ENV TZ=Europe/Berlin \
    LC_ALL=C.UTF-8

COPY --from=TZDATA /usr/share/zoneinfo/UTC /usr/share/zoneinfo/UTC
COPY --from=TZDATA /usr/share/zoneinfo/Europe/Berlin /usr/share/zoneinfo/Europe/Berlin

RUN microdnf -y install rsyslog && microdnf clean all && rm -rf /etc/rsyslog.d/*

COPY root /

USER 1001

ENTRYPOINT ["/usr/sbin/rsyslogd", "-n"]
