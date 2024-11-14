FROM ubuntu:24.04

COPY install.sh /tmp/install.sh
COPY conf/starship.toml /root/.config/starship.toml

RUN chmod +x /tmp/install.sh && /tmp/install.sh

SHELL ["/usr/bin/fish", "-c"]

CMD ["fish"]
