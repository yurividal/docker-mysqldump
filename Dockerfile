FROM alpine:3.9

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_HOST
ARG MYSQL_DATABASE
ARG HOURS_TO_KEEP
ARG REMOTE_IP
ARG REMOTE_DIR
ARG SSH_USERNAME
ARG SSH_PASS
RUN apk add --no-cache mysql-client openssh-client nano sshpass
ENTRYPOINT ["crond", "-f"]
