# Cloudflare Tunnel client
A lightweight container image of the [Cloudflare Tunnel client](https://github.com/cloudflare/cloudflared) with support for armv7, arm64 and amd64

## Setup with docker compose

### docker-compose.yml
```yaml
version: "3.8"

services:
  cloudflare-tunnel:
    container_name: cloudflare-tunnel
    image: ghcr.io/shmick/docker-cloudflared
    user: 1000:1000
    network_mode: host
    environment: 
      - TUNNEL_ID=<my tunnel>
      - TUNNEL_METRICS=localhost:21000
    command: tunnel run
    volumes:
      - ./config:/etc/cloudflared
    restart: unless-stopped
```

## 2 files in the config/ directory
### 1) mytunnel.json 

This will be created from running `cloudflared tunnel create` and the contents will look like:
```json
{"AccountTag":"xxxx","TunnelSecret":"xxxx","TunnelID":"xxxx","TunnelName":"mytunnel"}
```

### 2) config.yaml 
This contains the tunnel specific configs and will look like:

```yaml
tunnel: xxxx
credentials-file: /etc/cloudflared/mytunnel.json

ingress:
  - hostname: mytunnel.example.com
    service: http://localhost:8080
```
