FROM alpine

USER root

RUN mkdir /kubetemp \
    && mkdir /kubeval

RUN addgroup kvuser && adduser -S -G kvuser kvuser \
 && chown kvuser:kvuser /kubeval && chmod 755 /kubeval

WORKDIR /kubetemp

ENV KUBE_LATEST_VERSION="v1.20.0"
ENV OVERLAY_PATH="/kubeval/overlay"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && export ARCH="$(uname -m)" && if [[ ${ARCH} == "x86_64" ]]; then export ARCH="amd64"; fi && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/${ARCH}/kubectl -o /usr/local/bin/kubectl \
 && curl -L https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz -o /kubetemp/kubeval-linux-amd64.tar.gz \
 && tar xf /kubetemp/kubeval-linux-amd64.tar.gz \
 && cp /kubetemp/kubeval /usr/local/bin \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && rm /kubetemp/kubeval-linux-amd64.tar.gz

USER kvuser

CMD kubectl kustomize $OVERLAY_PATH | kubeval