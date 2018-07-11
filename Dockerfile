FROM drewgwallace/telegraf
MAINTAINER drewgwallace

# ENV INFLUX_DATABASE_HOSTNAME "192.168.1.1"
# ENV INFLUX_DATABASE_NAME "telegraf"
# ENV INFLUX_DATABASE_USER "username"
# ENV INFLUX_DATABASE_PASS "1234"
# ENV SNMP_COMM_STRING "public"
# ENV UNIFI_AP_HOSTNAME "uap1, uap2"


#SNMP Unifi

RUN apt-get update && \
  apt-get install -y snmp snmp-mibs-downloader curl && \
  download-mibs && \
  apt-get clean -qy && \
  curl -L https://github.com/pgmillon/observium/blob/master/mibs/FROGFOOT-RESOURCES-MIB -o /usr/share/snmp/mibs/FROGFOOT-RESOURCES-MIB && \
  curl -L http://dl.ubnt-ut.com/snmp/UBNT-UniFi-MIB -o /usr/share/snmp/mibs/UBNT-UniFi-MIB && \
  curl -L http://dl.ubnt-ut.com/snmp/UBNT-MIB -o /usr/share/snmp/mibs/UBNT-MIB && \
  curl -L https://raw.githubusercontent.com/drewgwallace/grafana-dashboards/implement_env_variables/UniFi-UAP/telegraf-inputs.conf -o /etc/telegraf/telegraf.d/telegraf-unifi-inputs.conf

# Tini entrypoint

ARG ARCH=amd64
ARG TINI_VERSION=v0.18.0

RUN apt-get update && \
    apt-get install -y curl gnupg && \
    apt-get clean -qy && \
    curl -L https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${ARCH} -o /sbin/tini && \
    curl -L https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${ARCH}.asc -o /sbin/tini.asc && \
    gpg --batch --keyserver hkp://keyserver.ubuntu.com --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 && \
    gpg --batch --verify /sbin/tini.asc /sbin/tini && \
    rm -f /sbin/tini.asc && \
    chmod 0755 /sbin/tini

EXPOSE 161

COPY telegraf-unifi.init /usr/bin/telegraf-unifi.init

ENTRYPOINT ["/sbin/tini", "-g", "--", "/usr/bin/telegraf-unifi.init"]