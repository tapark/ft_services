#!/bin/sh
/usr/sbin/influxd -config /etc/influxdb.conf & sleep 5

influx -execute "CREATE DATABASE grafana"
influx -execute "CREATE USER tapark WITH PASSWORD '1234' with all privileges"
influx -execute "GRANT ALL ON grafana TO tapark"

/telegraf/usr/bin/telegraf & sleep infinite