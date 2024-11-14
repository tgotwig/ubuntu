#!/bin/bash

set -e

apt update && apt install -y --no-install-recommends \
  curl=8.5.0-2ubuntu10.4 \
  iputils-ping=3:20240117-1build1 \
  netcat-openbsd=1.226-1ubuntu2

rm -rf /var/lib/apt/lists/*
