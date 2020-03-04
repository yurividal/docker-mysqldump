This container uses a script located in etc/periodic/daily/backup to do:
  - generate mysqldump of the selected database
  - tar the dump and save it to /backups
  - clean backups older than X days
  - copy the new backup to a remote server using scp
  - clean the remote server from backups older than X days


MANDATORY VARIABLES:

MYSQL_USER

MYSQL_PASSWORD

MYSQL_HOST

MYSQL_DATABASE

DAYS_TO_KEEP

REMOTE_IP

REMOTE_DIR

SSH_USERNAME

SSH_PASS


##### bin/crontab
```
#minute hour    day     month   week    command
0       0       *       *       *       /usr/local/bin/backup
```

##### bin/backup
```
#!/bin/sh

now=$(date +"%s_%Y-%m-%d")
/usr/bin/mysqldump --opt -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} > "/backup/${now}_${MYSQL_DATABASE}.sql"
```

## Use as cronjob container (without overwriting bin/crontab)

The container has a proper crontab by default:

```
# do daily/weekly/monthly maintenance
# min	hour	day	month	weekday	command
*/15	*	*	*	*	run-parts /etc/periodic/15min
0	*	*	*	*	run-parts /etc/periodic/hourly
0	2	*	*	*	run-parts /etc/periodic/daily
0	3	*	*	6	run-parts /etc/periodic/weekly
0	5	1	*	*	run-parts /etc/periodic/monthly
```

If these execution times suffice, you can simply mount your backup script into the proper folder:

```
version: '2'
services:
  ...
  cron:
    image: schnitzler/mysqldump
    restart: always
    volumes:
      - ./bin/backup:/etc/periodic/daily/backup
    volumes_from:
      - backup
    command: ["-l", "8", "-d", "8"]
    environment:
      MYSQL_HOST: db
      MYSQL_USER: user
      MYSQL_PASSWORD: password
      MYSQL_DATABASE: database
  ...
```

## Use for a single backup

In this case you simply empty the `entrypoint` and run the mysqlump `command`.

```
docker run \
    --rm --entrypoint "" \
    -v `pwd`/backup:/backup \
    --link="container:alias" \
    schnitzler/mysqldump \
    mysqldump --opt -h alias -u user -p"password" "--result-file=/backup/dumps.sql" database
```
