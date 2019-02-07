#!/bin/bash

# Set the environmental variables
TIMESTAMP=$(date '+%F')
path="/home/ubuntu/dbbackup/"
logname=log_back_$TIMESTAMP.txt
log=$path/$logname

DISKSPACE=$(df -h | awk 'NR==4{print substr($3, 1, length($2)-1)}')

DEFINEDSPACE=80;

CONSUMEDSPACE=$(du -sh $HOME/dbbackup | awk '{print substr($1, 1, length($1)-1)}')

echo "Log date ------> $TIMESTAMP"
echo "Consumed Disk Space ----> $DISKSPACE GB"
echo "defined space -----> $DEFINEDSPACE GB"
echo "dbbackup consumed space -----> $CONSUMEDSPACE GB"

if [[ $DISKSPACE -ge $DEFINEDSPACE ]]; then
        echo "$DISKSPACE GB is greater than or equal to $DEFINEDSPACE GB"

        # DB backup files older than 8 days files will be deleted
        find "$path" -daystart -name "*.sql.gz" -mtime +8 -type f -print -exec rm {} \;
else
        echo "$DISKSPACE GB is less than or not equal to $DEFINEDSPACE GB"
fi

echo "Success"
exit 0
