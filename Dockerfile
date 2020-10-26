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
ARG FREQUENCY
ADD backup /etc/periodic/${FREQUENCY}
RUN chmod +x /etc/periodic/${FREQUENCY}/backup
RUN apk add --no-cache sshpass mysql-client openssh-client nano
ENTRYPOINT ["crond", "-f"]