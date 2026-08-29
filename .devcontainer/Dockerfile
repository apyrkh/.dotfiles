FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

USER root

RUN useradd --create-home --shell /usr/bin/zsh --groups sudo dev \
  && echo 'dev ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/dev \
  && chmod 0440 /etc/sudoers.d/dev

USER dev
