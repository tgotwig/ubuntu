#!/bin/bash

set -e

apt update && apt install -y --no-install-recommends \
  ca-certificates \
  curl \
  dnsutils \
  fish \
  git \
  iproute2 \
  iputils-ping \
  netcat-openbsd \
  nmap \

curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo 'fish_add_path /root/.local/bin' > /etc/fish/config.fish
echo 'zoxide init fish | source' >> /etc/fish/config.fish

curl -sS https://starship.rs/install.sh | sh -s -- -y
echo 'starship init fish | source' >> /etc/fish/config.fish

sh -c "$(curl -sSL https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

rm -rf /var/lib/apt/lists/*
