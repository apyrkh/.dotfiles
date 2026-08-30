FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends bash ca-certificates git sudo \
  && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash dotfiles \
  && echo 'dotfiles ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/dotfiles \
  && chmod 0440 /etc/sudoers.d/dotfiles

COPY --chown=dotfiles:dotfiles . /opt/dotfiles

USER dotfiles
ENV HOME=/home/dotfiles

RUN /opt/dotfiles/tests/linux-smoke.sh
