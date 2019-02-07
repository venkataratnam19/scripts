#!/usr/bin/env bash
ora=`date '+%Y-%m-%d'`
cd /home/ubuntu/dbbackup
gzip -d *mysqldump_$ora*
filename=`find /home/ubuntu/dbbackup/*$ora*.sql`
mysql -h mysql-archive.*******.us-east-1.rds.amazonaws.com -P 3306 -u root --password=***** < $filename #import DB

