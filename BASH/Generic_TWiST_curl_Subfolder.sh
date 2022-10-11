#!/bin/bash

# The workflow you want this script to send files to
Workflow=03_Crisis_Country

# The location of the files you wan this script to look for files in
MainFolder=/mnt/NAS/Users/Hotfolders/Crisis_Auto_Topo

# Delay is in seconds between transmissions of a file to a server
Delay=20

# List of files to send to servers
find $MainFolder -maxdepth 2 -name "*.pdf" > /tmp/FileList

LOG=/mnt/NAS/Users/ADMIN/log/$HOSTNAME/$(date +%F)_Generic_TWiST_curl_Subfolder.log

((
while read -r line; do
  ParentFolder=$(echo $line | cut -s -d/ -f 1,2,3,4,5,6,7,8)
  NSN_NRN_ED=$(cat $ParentFolder/NSN_NRN_ED) && rm $ParentFolder/NSN_NRN_ED
  find $ParentFolder -maxdepth 1 -name "*.pdf" -print -exec mv {} $ParentFolder/$NSN_NRN_ED.pdf \;
  echo "$(date "+%D %H:%M:%S") Sending the File $ParentFolder/$NSN_NRN_ED.pdf to the Workflow $Workflow on the Server $S"
  curl -s -S http://server1:8080/twist/twistUpload -F name=$Workflow -F file=@$ParentFolder/$NSN_NRN_ED.pdf
  echo "Waiting $Delay seconds to send the next file"
  sleep $Delay
done < /tmp/FileList
) 2>&1 >> $LOG)
