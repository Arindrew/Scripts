#!/bin/bash 

#Define colors for stdout
function colors_stdout()
{
RED='\033[0;031m'
LRED='\033[1;031m'
GREEN='\033[0;032m'
NC='\033[0m'
}

# Destination folder to search in
searchDir=/mnt/NAS/WorkingFiles/Workflows/12_Automate_noQRCode/IRS2

# Directory of filenames to iterate the search through
sourceDir=/mnt/NAS/InputData/2024-10-30_IRS2/ST_Delivery_UkraineBelarus/Processed

# TWiST Workflow Name to send files to 
workflow=12_Automate_noQRCode

#Delay is in seconds. This is the wait time between transmissions.
Delay=30

while IFS= read -r line; do
  series=${line:0:5}
  if ! find $searchDir/$series/ -name "$line" -type f -print -quit | grep -q .; then
    echo -e "${LRED}$line${NC} not found.  curling"
    curl -s -S http://ndwsstwslpdal08:8080/twist/twistUpload -F name="$workflow" -F file=@$sourceDir/$line
    for seconds in $(eval echo "{$Delay..01}"); do 
      sleep 1
      echo -en "${GREEN}.${NC}"; 
    done
  else
    echo -en "${GREEN}$line${NC}" has been found. yay!
  fi
echo ""
done < <(ls $sourceDir)

colors_stdout
