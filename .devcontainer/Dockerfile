FROM ubuntu:24.04

# install.sh installs everything else (git, curl, build tools, Node, Neovim, ...)
# itself; the base image only needs to supply sudo (for the installer's own
# apt-get calls) and a non-root user before that runs.
#
# Ubuntu's official image already ships a uid 1000 user ("ubuntu", for
# cloud-init) that's already in the sudo group. Rename it to "dev" instead of
# creating a new user at a different uid, which would conflict and also not
# match the bind-mounted workspace's usual ownership on Linux hosts.
#
# Keep the login shell as /bin/bash here: zsh is only installed later by
# install.sh's postCreateCommand run, so setting it as the shell now would
# point at a binary that doesn't exist yet.
RUN apt-get update \
  && apt-get install -y --no-install-recommends sudo \
  && rm -rf /var/lib/apt/lists/* \
  && usermod --login dev --move-home --home /home/dev ubuntu \
  && groupmod --new-name dev ubuntu \
  && echo 'dev ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/dev \
  && chmod 0440 /etc/sudoers.d/dev

USER dev
