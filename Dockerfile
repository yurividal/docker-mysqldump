FROM alpine:3.9

RUN apk add --no-cache mysql-client openssh-client nano
ENTRYPOINT ["crond", "-f"]
