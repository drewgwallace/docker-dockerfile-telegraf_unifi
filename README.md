# WORK IN PROGRESS
# Docker Dockerfile



## Purpose
  Dockerfile to create a telegraf snmp listener for a Unifi AP.
  
----

## Execution

<pre>
    docker run \
    -e INFLUX_DATABASE_HOSTNAME="<b>192.168.1.1</b>" \
    -e INFLUX_DATABASE_NAME="<b>TELEGRAF</b>" \
    -e INFLUX_DATABASE_USER="<b>USER</b>" \
    -e INFLUX_DATABASE_PASS="<b>PASSWORD</b>" \
    -e SNMP_COMM_STRING="<b>PUBLIC</b>" \
    -e UNIFI_AP_HOSTNAME="<b>AP1, AP2</b>" \
    -dt drewgwallace/telegraf_unifi
</pre>
### Build yourself with docker compose
<pre>
    git clone https://github.com/drewgwallace/docker-dockerfile-telegraf_unifi.git
    cd docker-dockerfile-telegraf_unifi
    docker build -t <b>USERNAME/</b>telegraf_unifi .
    docker push <b>USERNAME/</b>telegraf_unifi
</pre>   

### Image on [Docker Hub](https://hub.docker.com/r/drewgwallace/telegraf_unifi/)

----

## Notes
