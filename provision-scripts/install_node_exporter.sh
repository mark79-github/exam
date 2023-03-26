#!/bin/bash

echo "* Download node exporter"
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz

echo "* Extract node exporter"
tar xzvf node_exporter-1.5.0.linux-amd64.tar.gz

echo "* Start node exporter"
cd node_exporter-1.5.0.linux-amd64/ && ./node_exporter &> /tmp/node-exporter.log &
