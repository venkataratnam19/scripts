#!/bin/bash
set -x
set -e
#set the environmental variables
AWSUSERNAME='ubuntu'
AWSIPADDRESS='*******'
TIMESTAMP=$(date '+%F')
path="/home/$USER/dbbackupscripts/"
logname=log_back_$TIMESTAMP.txt
log=$path/$logname

#Start the backup of Beerboard Mysql DB and save the log time in log back file
echo "Backup:: Script Start -- $(date +%Y/%m/%d_%H:%M:%S)" >> $log
START_TIME=$(date +%s)

echo "login into DB Server"
pwd
# Passing DB credentials by using cnf file
cat > /home/$USER/.mysqllogin.cnf <<- "EOF"
[client]
user = dbusername
password = dbpassword
EOF

# change the permissions for DB credentials
chmod 600 /home/$USER/.mysqllogin.cnf

# Run the mysqldump command to import the DB backup from mysql server
/usr/bin/mysqldump --defaults-extra-file=/home/$USER/.mysqllogin.cnf -u dbusername beerboardb > dbbackup-$(date +%F).sql.gz

# Upload the DB backup.sql file into backup destination server
scp -i $path/ec2.pem -r dbbackup-$(date '+%F').sql.gz $AWSUSERNAME@$AWSIPADDRESS:/home/ubuntu/dbbackup/

END_TIME=$(date +%s)

ELAPSED_TIME=$(( $END_TIME - $START_TIME ))

echo "Backup :: Script End -- $(date +%Y/%m/%d_%H:%M:%S)" >> $log

echo "Elapsed Time ::  $(date -d 00:00:$ELAPSED_TIME +%Hh:%Mm:%Ss) "  >> $log

