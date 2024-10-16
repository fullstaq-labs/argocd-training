FROM mcr.microsoft.com/devcontainers/base:debian

COPY --from=ghcr.io/charmbracelet/gum /usr/local/bin/gum /usr/local/bin/gum

RUN curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
RUN sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
RUN rm argocd-linux-amd64

RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx
RUN ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
RUN ln -s /opt/kubectx/kubens /usr/local/bin/kubens

ENV CERT_MANAGER_VERSION="1.15.3"
ENV ARGOCD_VERSION="7.4.4"