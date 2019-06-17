FROM alpine:3.9

# Note: Latest version of kubectl may be found at:
# https://aur.archlinux.org/packages/kubectl-bin/
ENV KUBE_LATEST_VERSION="v1.14.3"
# Note: Latest version of helm may be found at:
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v2.14.1"

ENV DOCTL_VERSION=1.20.0

RUN apk add --no-cache ca-certificates bash git openssh curl \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && wget -q https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz  -O - | tar -xzO doctl > /usr/local/bin/doctl \
    && chmod +x /usr/local/bin/doctl

WORKDIR /config

CMD bash