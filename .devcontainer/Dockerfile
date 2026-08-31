FROM ubuntu:24.04

# Base image only needs sudo + a non-root user; install.sh does the rest.
# Rename Ubuntu's stock uid-1000 "ubuntu" user to "dev" (keeps bind-mount
# ownership sane). Shell stays bash — zsh isn't installed until install.sh runs.
RUN apt-get update \
  && apt-get install -y --no-install-recommends sudo \
  && rm -rf /var/lib/apt/lists/* \
  && usermod --login dev --move-home --home /home/dev ubuntu \
  && groupmod --new-name dev ubuntu \
  && echo 'dev ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/dev \
  && chmod 0440 /etc/sudoers.d/dev

USER dev
