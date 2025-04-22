FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends \
  ca-certificates \
  curl \
  dnsutils \
  fish \
  git \
  iproute2 \
  iputils-ping \
  netcat-openbsd \
  nmap \
  tree \
  wget && \
  rm -rf /var/lib/apt/lists/*

RUN echo "[1/4] Installing zoxide..." && \
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh && \
  echo 'fish_add_path /root/.local/bin' > /etc/fish/config.fish && \
  echo 'zoxide init fish | source' >> /etc/fish/config.fish

RUN echo "[2/4] Installing starship..." && \
  curl -sS https://starship.rs/install.sh | sh -s -- -y && \
  echo 'starship init fish | source' >> /etc/fish/config.fish

RUN echo "[3/4] Installing Task runner..." && \
  sh -c "$(wget -qO- https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

RUN echo "[4/4] Installing ASDF..." && \
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
  wget -qO /usr/local/etc/fish/conf.d/asdf.fish "https://raw.githubusercontent.com/asdf-vm/asdf/refs/tags/v0.16.7/asdf.fish" && \
  echo 'source /usr/local/etc/fish/conf.d/asdf.fish' >> /etc/fish/config.fish && \
  echo 'asdf completion fish | source' >> /etc/fish/config.fish

COPY conf/starship.toml /root/.config/starship.toml

SHELL ["/usr/bin/fish", "-c"]

CMD ["fish"]
