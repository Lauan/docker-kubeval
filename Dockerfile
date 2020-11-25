FROM alpine

USER root

RUN mkdir /kubetemp \
    mkdir /kubeval

RUN addgroup kvuser && adduser -S -G kvuser kvuser
RUN chown kvuser:kvuser /kubeval && chmod 755 /kubeval

COPY ./kubeval-linux-amd64.tar.gz /kubetemp

WORKDIR /kubetemp

RUN tar xf kubeval-linux-amd64.tar.gz
RUN cp kubeval /usr/local/bin

USER kvuser

ENTRYPOINT ["kubeval"]
CMD ["-d","/kubeval"]