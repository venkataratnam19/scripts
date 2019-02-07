#!/bin/bash

# Set the environmental variables
TIMESTAMP=$(date '+%F')
path="/home/$USER/dbbackup/"
logname=log_back_$TIMESTAMP.txt
log=$path/$logname


DISKSPACE=$(df -h | awk 'NR==4{print substr($3, 1, length($2)-1)}')

DEFINEDSPACE=80;

CONSUMEDSPACE=$(du -sh $HOME/dbbackup | awk '{print substr($1, 1, length($1)-1)}')

echo "Free Disk Space ----> $DISKSPACE"
echo "defined space -----> $DEFINEDSPACE"
echo "dbbackup consumed space -----> $CONSUMEDSPACE"

if [[ $DISKSPACE -ge $DEFINEDSPACE ]]; then
        echo "$DISKSPACE is greater than or equal to $DEFINEDSPACE"

        # DB backup files older than 8 days files will be deleted
        find "$path" -name "*.sql.gz" -mtime +8 -type f -print
else
        echo "$DISKSPACE is less than or not equal to $DEFINEDSPACE"
fi

echo "Success"
exit 0
