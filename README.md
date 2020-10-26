This container uses a script located in etc/periodic/\<frequency\> to do:

- generate mysqldump of the selected database and files/folders
- tar the dump and the files and save it to /backups
- clean backups older than X days
- copy the new backup to a remote server using scp
- clean the remote server from backups older than X days


#### HOW TO USE

Pull the image yurividal/sqldumpsshcron:latest


#### MANDATORY VARIABLES:

None

#### OPTIONAL VARIABLES:
VARIABLE

|VARIABLE|DESCRIPTION|EXAMPLE|
|--------|:---------|:--------|
|**FREQUENCY**|How often backup should run. Default: daily. Accepted:15min,hourly,daily,weekly,monthly|weekly|
|**BACKUP_THESE**|The Files and Folders that should be included in the bkp|/path/to/folder,path/to/file.extention|  
|**DAYS_TO_KEEP**|Optional number of **days** to keep in backup. If not set, will keep all backups forever.| 30 |  
|**MYSQL_DATABASE**|Name of database that will be backed up as sqldump|my_table|  
|**MYSQL_USER**|MANDATORY if MYSQL_DATABASE is set|root|  
|**MYSQL_PASSWORD**|MANDATORY if MYSQL_DATABASE is set|MyPassword|  
|**MYSQL_HOST**|MANDATORY if MYSQL_DATABASE is set|mariadb_container|  
|**REMOTE_IP**|The IP of the Remobe Backup Server|192.168.0.147|  
|**REMOTE_DIR**|MANDATORY if REMOTE_IP is set. The directory in the remote backup server. Full path.|/mnt/UKDataStore/UKFreeNAS/Backups/phpipam|  
|**SSH_USERNAME**|MANDATORY if REMOTE_IP is set|user|  
|**SSH_PASS**|MANDATORY if REMOTE_IP is set.|myShhPass|

## Predefined Times:

The container has the following crontab by default:

```
# do daily/weekly/monthly maintenance
# min	hour	day	month	weekday	command
*/15	*	*	*	*	run-parts /etc/periodic/15min
0	*	*	*	*	run-parts /etc/periodic/hourly
0	2	*	*	*	run-parts /etc/periodic/daily
0	3	*	*	6	run-parts /etc/periodic/weekly
0	5	1	*	*	run-parts /etc/periodic/monthly
```
