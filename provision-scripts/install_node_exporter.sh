#!/bin/bash

if [ -f "node_exporter-1.5.0.linux-amd64.tar.gz" ]; then
    echo "*** Node exporter binary files found ..."
else 
    echo "* Download node exporter"
    wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
fi

if [ -d "node_exporter-1.5.0.linux-amd64/" ]; then
    echo "*** Node exporter directory found ..."
else 
    echo "* Extract node exporter"
    tar xzvf node_exporter-1.5.0.linux-amd64.tar.gz
fi

echo "* Start node exporter"
cd node_exporter-1.5.0.linux-amd64/ && ./node_exporter &> /tmp/node-exporter.log &
