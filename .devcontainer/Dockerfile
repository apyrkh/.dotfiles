FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

USER root

# The base image already ships a uid 1000 user ("vscode") with passwordless
# sudo, and Dev Containers normally owns the bind-mounted workspace as uid
# 1000. Rename that user to "dev" instead of creating a new user at a
# different uid, which caused workspace permission errors.
RUN usermod --login dev --move-home --home /home/dev --shell /usr/bin/zsh vscode \
  && groupmod --new-name dev vscode \
  && mv /etc/sudoers.d/vscode /etc/sudoers.d/dev \
  && sed -i 's/^vscode /dev /' /etc/sudoers.d/dev

USER dev
