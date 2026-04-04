FROM ubuntu:24.04

RUN apt update && apt install -y --no-install-recommends \
  bat \
  build-essential \
  ca-certificates \
  curl \
  dnsutils \
  fd-find \
  fish \
  git \
  gnupg \
  iproute2 \
  iputils-ping \
  jq \
  less \
  lsd \
  mediainfo \
  micro \
  netcat-openbsd \
  nmap \
  openssh-client \
  ripgrep \
  sd \
  stow \
  tree \
  unzip \
  wget && \
  rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
  chmod a+r /etc/apt/keyrings/docker.asc && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list && \
  apt update && \
  apt install -y docker-ce-cli docker-compose-plugin && \
  rm -rf /var/lib/apt/lists/*

RUN echo "[1/5] Installing atuin..." && \
  curl -fsSL https://setup.atuin.sh | bash

RUN echo "[2/5] Installing zoxide..." && \
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

RUN echo "[3/5] Installing starship..." && \
  curl -sS https://starship.rs/install.sh | sh -s -- -y

RUN echo "[4/5] Installing Task runner..." && \
  sh -c "$(wget -qO- https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

RUN echo "[5/6] Installing dust..." && \
  arch="$(uname -m)" && \
  case "$arch" in \
  x86_64) dust_arch="x86_64-unknown-linux-musl" ;; \
  aarch64) dust_arch="aarch64-unknown-linux-musl" ;; \
  *) echo "Unsupported architecture: $arch"; exit 1 ;; \
  esac && \
  wget -qO - "https://github.com/bootandy/dust/releases/download/v1.1.1/dust-v1.1.1-${dust_arch}.tar.gz" \
  | tar -xzf - -C /usr/local/bin --strip-components=1 dust-v1.1.1-${dust_arch}/dust

RUN echo "[6/6] Installing ASDF..." && \
  arch="$(uname -m)" && \
  case "$arch" in \
  x86_64) asdf_arch="amd64" ;; \
  aarch64) asdf_arch="arm64" ;; \
  *) echo "Unsupported architecture: $arch"; exit 1 ;; \
  esac && \
  mkdir -p /opt/asdf && \
  wget -qO - "https://github.com/asdf-vm/asdf/releases/download/v0.16.7/asdf-v0.16.7-linux-${asdf_arch}.tar.gz" \
  | tar -xzf - -C /opt/asdf && \
  ln -s /opt/asdf/asdf /usr/local/bin/asdf && \
  mkdir -p /usr/local/etc/fish/conf.d && \
  wget -qO /usr/local/etc/fish/conf.d/asdf.fish "https://raw.githubusercontent.com/asdf-vm/asdf/refs/tags/v0.16.7/asdf.fish"

COPY dotfiles/ /root/dotfiles/

RUN cd /root/dotfiles && stow */

SHELL ["/usr/bin/fish", "-c"]

CMD ["fish"]
