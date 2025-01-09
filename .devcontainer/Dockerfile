FROM mcr.microsoft.com/devcontainers/python

COPY --from=ghcr.io/charmbracelet/gum:v0.14.1 /usr/local/bin/gum /usr/local/bin/gum
COPY --from=ghcr.io/siderolabs/talosctl:v1.8.1 /talosctl /usr/local/bin/talosctl

RUN sudo apt update && sudo apt install -y --no-install-recommends \
  entr git &&\
  talosctl completion bash > /etc/bash_completion.d/talosctl

RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx
RUN ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
RUN ln -s /opt/kubectx/kubens /usr/local/bin/kubens
