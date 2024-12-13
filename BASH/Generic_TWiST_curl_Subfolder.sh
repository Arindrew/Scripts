#!/bin/bash

# Create destination directory for log output
if [[ ! -d /mnt/NAS/DalimUsers/ADMIN/log/dalim/$HOSTNAME ]]; then
  mkdir -p /mnt/NAS/DalimUsers/ADMIN/log/dalim/$HOSTNAME
fi

# The Workflow you want this script to send files to
Workflow=14_Automate_noQRCode

# The location of the files you want this script to look for file in
MainFolder=/mnt/NAS/InputData/2024-02-14_5K-PDFs

# Delay is in seconds. This is wait time between transmissions.
Delay=20

while read -r line; do
  echo "$(date "+%D %H:%M:%S") Sending the File $line to the Workflow $Workflow"
  curl -s -S http://ndwsstwslpdal01:8080/twist/twistUpload -F name=$Workflow -F file=@$line
  echo "Waiting $Delay seconds to send next file"
  sleep $Delay
done < <(find $MainFolder -maxdepth 3 -name "*.pdf")
