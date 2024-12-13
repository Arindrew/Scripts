#!/bin/bash

#Define colors for stdout
RED='\033[0;31m'
LRED='\033[1;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No color

# The Workflow you want this script to send files to
Workflow=14_Automate_noQRCode

#Delay is in seconds. This is wait time between transmissions.
Delay=30

#Define your path to the file list here
FileList=/path/to/file

while read -r line; do 
  echo "$(date "+%D %H:%M:%S") Sending: $line"
  curl -s -S http://ndwsstwslpdal08:8080/twist/twistUpload -F name=$Workflow -F file=@$line
  echo -n "Waiting $Delay seconds: "
  for seconds in $(eval "echo {$Delay..01}"); do 
    sleep 1 #keep at 1, set actual delay in variable above
    echo -en "${GREEN}.${NC}"; 
  done
echo ""
done < $FileList
