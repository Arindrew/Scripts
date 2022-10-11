#!/bin/bash

# The workflow you want this script to send files to
Workflow=12_ctptransfer_Publish

# Delay is in seconds between transmissions of a file to a server
Delay=20

LOG=/mnt/NAS/Users/ADMIN/log/$HOSTNAME/$(date +%F)_Generic_TWiST_curl_List.log

((
  while read -r line; do
    echo "$(date "+%D %H:%M:%S") Sending the file $line to the workflow $Workflow on the server $S"
    curl -s -S http://server1:8080/twist/twistUpload -F name=$Workflow -F file=@$line
    echo "Waiting $Delay seconds to send next file"
    sleep $Delay
  done < /root/publishList_Trimmed
) 2>&1 >> $LOG)
