FROM alpine:3.12

RUN apk add dcron

COPY cron.sh /cron.sh

CMD ["/cron.sh"]

