# Cloudflare Tunnel client
A lightweight container image of the [Cloudflare Tunnel client](https://github.com/cloudflare/cloudflared) with support for armv7, arm64 and amd64

![Build Status](https://github.com/shmick/docker-cloudflared/actions/workflows/build.yml/badge.svg)
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
      - TUNNEL_TOKEN=<long tunnel token string>
      - TUNNEL_METRICS=localhost:21000
    command: tunnel run
    restart: unless-stopped
```
