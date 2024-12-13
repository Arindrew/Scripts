#!/bin/bash

#Define colors for stdout
RED='\033[0;31m'
LRED='\033[1;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No color

# The Workflow you want this script to send files to
Workflow=12_Automate_noQRCode

#The location of the files you want this script to look for file in
Folder=/mnt/NAS/InputData/002_CPENs/2024-12-04_41

#Delay is in seconds. This is wait time between transmissions.
Delay=60

while read -r line; do 
  echo "$(date "+%D %H:%M:%S") Sending: $(echo $line | rev | cut -d/ -f1 | rev)"
  curl -s -S http://ndwsstwslpdal08:8080/twist/twistUpload -F name=$Workflow -F file=@$line
  mv "$line" $Folder/Processed/
  for seconds in $(eval "echo {$Delay..01}"); do 
    sleep 1
    echo -en "${GREEN}.${NC}";
  done
echo ""
done < <(find $Folder -maxdepth 1 -type f -name "*.pdf")

# How to remove layered_attributed from each file
########
#  while read -r file; do 
#    mv $file ${file:0:16}.pdf
#  done < <(find . -maxdepth 1 -type f -name "*layered_attributed.pdf")
#######
