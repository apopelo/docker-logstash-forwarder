FROM alpine

MAINTAINER Andrey Popelo andrey@popelo.com

ENV LOGSTASH_FORWARDER_VERSION 0.4.0

RUN apk add --update curl go && \
    mkdir /opt && \
    curl -Ls https://github.com/elastic/logstash-forwarder/archive/v$LOGSTASH_FORWARDER_VERSION.tar.gz | tar -vxz -C /opt && \
    ln -s /opt/logstash-forwarder-$LOGSTASH_FORWARDER_VERSION /opt/logstash-forwarder && \
    cd /opt/logstash-forwarder && \
    go build && \
    apk del -r curl go

CMD ["/opt/logstash-forwarder/logstash-forwarder", "-config", "/etc/logstash-forwarder/config.json"]
