FROM alpine

USER root

RUN mkdir /kubeinstall \
    mkdir /kubeval

RUN addgroup kvuser && adduser -S -G kvuser kvuser
RUN chown kvuser:kvuser /kubeval && chmod 755 /kubeval

COPY ./kubeval-linux-amd64.tar.gz /kubeinstall

WORKDIR /kubeinstall

RUN tar xf kubeval-linux-amd64.tar.gz
RUN cp kubeval /usr/local/bin

USER kvuser

ENTRYPOINT ["kubeval"]
CMD ["-d","/kubeval"]