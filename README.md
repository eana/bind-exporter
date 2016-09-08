# Bind Exporter

Export BIND(named/dns) v9+ service metrics to Prometheus.

## Getting started

```bash
docker build -t bind-exporter github.com/eana/bind-exporter
HOSTIP=$(ip -4 a s dev docker0 | grep inet | awk '{print $2}' | cut -d / -f 1)
docker run --name bind-exporter -d -p 9119:9119 -e URI=http://${HOSTIP}:8053/ bind-exporter
```

## Troubleshooting

Make sure BIND was built with libxml2 support. You can check with the following
command: `named -V | grep libxml2`.

Configure BIND to open a statistics channel.

```
statistics-channels {
  inet x.x.x.x port 8080 allow { y.y.y.y; };
};
```

where

```bash
x.x.x.x is ip -4 a s dev docker0 | grep inet | awk '{print $2}' | cut -d / -f 1
y.y.y.y is ip -4 a s dev docker0 | grep inet | awk '{print $2}'
```
