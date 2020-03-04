FROM alpine:3.9

GIT_URL=""; \
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_HOST
ARG MYSQL_DATABASE
ARG HOURS_TO_KEEP
ARG REMOTE_IP
ARG REMOTE_DIR
ARG SSH_USERNAME
ARG SSH_PASS
RUN apk add --no-cache mysql-client openssh-client nano wget
RUN wget --no-check-certificate -O /etc/periodic/daily/backup https://raw.githubusercontent.com/yurividal/docker-mysqldump/master/backup
RUN chmod +x /etc/periodic/daily/backup
ENTRYPOINT ["crond", "-f"]
