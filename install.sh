#!/bin/bash

set -e

apt update && apt install -y --no-install-recommends \
  ca-certificates \
  curl=8.5.0-2ubuntu10.4 \
  fish \
  iputils-ping=3:20240117-1build1 \
  netcat-openbsd=1.226-1ubuntu2 \

curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo 'fish_add_path /root/.local/bin' > /etc/fish/config.fish
echo 'zoxide init fish | source' >> /etc/fish/config.fish

rm -rf /var/lib/apt/lists/*
