#!/bin/bash

echo "* Copy prometheus configuration file ..."
cd /vagrant/prometheus && cp prometheus.yml /tmp

echo "* Install prometheus, grafana ..."
docker compose down || true
docker compose up -d
