#!/bin/bash
# Set the environmental variables
TIMESTAMP=$(date)

echo "Log date ------> $TIMESTAMP"
echo "Run this URL at Every 15 Minutes once"
#rm -rf /home/ubuntu/cronevry15min.log
#touch /home/ubuntu/cronevry15min.log
curl "http://example.com/nodejsserver/archiveReadingToAWS?beta=0"

exit

