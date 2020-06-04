FROM alpine:latest

RUN apk update \
    && apk add influxdb \
    && rm /etc/influxdb.conf

COPY influxdb.conf /etc/influxdb.conf

COPY setup.sh .
RUN chmod +x setup.sh

VOLUME [ "/var/lib/influxdb" ]

EXPOSE 8086

CMD ./setup.sh