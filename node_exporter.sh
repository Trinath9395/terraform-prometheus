#!/bin/bash
set -e  # Exit if any command fails

VERSION=1.9.1
INSTALL_DIR="/opt/node_exporter"

echo "==> Current directory: $(pwd)"

cd /opt
echo "==> Downloading Node Exporter v$VERSION..."
wget -q https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz
tar -xzf node_exporter-$VERSION.linux-amd64.tar.gz
mv node_exporter-$VERSION.linux-amd64 node_exporter
rm -f node_exporter-$VERSION.linux-amd64.tar.gz

echo "==> Cloning service configuration..."
cd /tmp
git clone https://github.com/Trinath9395/terraform-prometheus.git
cd terraform-prometheus

cp node_exporter.service /etc/systemd/system/node_exporter.service

echo "==> Starting Node Exporter service..."
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter

if ! systemctl is-active --quiet "node_exporter"; then
  echo "❌ ERROR: node_exporter is not running!"
  journalctl -u node_exporter -n 20 --no-pager
  exit 1
else
  echo "✅ node_exporter is running successfully!"
fi
