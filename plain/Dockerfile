FROM alpine

USER root

RUN mkdir /kubetemp \
 && mkdir /kubeval

RUN addgroup kvuser && adduser -S -G kvuser kvuser
RUN chown kvuser:kvuser /kubeval && chmod 755 /kubeval

WORKDIR /kubetemp

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz -o /kubetemp/kubeval-linux-amd64.tar.gz \
 && tar xf /kubetemp/kubeval-linux-amd64.tar.gz \
 && cp /kubetemp/kubeval /usr/local/bin \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && rm /kubetemp/kubeval-linux-amd64.tar.gz

USER kvuser

ENTRYPOINT ["kubeval"]
CMD ["-d","/kubeval"]