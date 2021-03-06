FROM alpine:3.9

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_HOST
ARG MYSQL_DATABASE
ARG DAYS_TO_KEEP
ARG REMOTE_IP
ARG REMOTE_DIR
ARG SSH_USERNAME
ARG SSH_PASS
ARG BACKUPS_TO_KEEP
ENV FREQUENCY=daily
RUN mkdir /bkpscript
ADD backup /bkpscript
RUN chmod +x /bkpscript/backup
RUN apk add --no-cache sshpass mysql-client openssh-client nano
ENTRYPOINT ln -s /bkpscript/backup /etc/periodic/${FREQUENCY}/backup && crond -f