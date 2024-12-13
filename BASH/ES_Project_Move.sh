#!/bin/bash

# A CSV must be generated with Kibana that lists the projects to be moved.
# This script will move those Projects out of the local-storage for ES and
# into remote-storage for ES. This will free up more space on the 
# local-storage for additional projects.

#Define colors for stdout
RED='\033[0;031m'
LRED='\033[1;031m'
GREEN='\033[0;032m'
NC='\033[0m'

# check for root
if [[ $EUID == 0 ]]; then

  # Define the path the CSV will be located
  CSVPath=/mnt/NAS/path/to/CSV
  
  # Define the folders that the Project can be found inside of
  ESComposite=/mnt/NAS/path/to/Composite
  ESInput=/mnt/NAS/path/to/Input
  
  # Define the folders that the completed projects will be moved into
  ESCompletedComposite=/mnt/NAS/path/to/CompletedComposite
  ESCompletedInput=/mnt/NAS/path/to/CompletedInput
  
  # Iterate through the CSV, cutting the cruft and leaving only the Project name
  while read -r job; do
    NRNed=$(echo "$job" | cut -d\" -f 4)
    ProjectC=$(find "$ESComposite" -iname "*NRNed*" -print -quit | cut -d/ -f 6)
    ProjectI=$(find "$ESInput" -iname "*NRNed*" -print -quit | cut -d/ -f 6)
    echo -e "1\n2"
    
    if [[ "$ProjectC" ]] && [[ "$ProjectI" ]]; then
      echo -e "$(date +%T) Project ${GREEN}$NRNed${NC} found in ${GREEN}$ProjectC${NC} and ${GREEN}$ProjectI${NC}"
      # Move the project out of the local-storage composite/input
      # folder and into the remote-storage composite/input folder
      echo -e "$(date +%T) Moving $ProjectC"
      mv "$ESComposite"/"$ProjectC" "ESCompletedComposite"/
      echo -e "$)date +%T) Moving $ProjectI"
      mv "$ESInput"/"$ProjectI" "ESCompletedInput"/
      # Create symbolic links in the local-storage
      # project folder to the remote-storage project folder
      echo -e "Creating symbolic links"
      ln -s "$ESCompletedComposite"/"$ProjectC" "$ESComposite"/"$ProjectC"
      ln -s "$ESCompletedInput"/"$ProjectI" "$ESInput"/"$ProjectI"
      # Chown the symbolic links just to be sure they have the correct ownership
      chown daltomcat:dalim -h "$ESComposite"/"ProjectC"
      chown daltomcat:dalim -h "$ESInput"/"ProjectI"
    else
      echo -e "Project ${LRED}$NRNed${NC} not found in ${GREEN}$ESComposite${NC} and/or ${GREEN}$ESInput${NC}"
    fi
  done <$CSVPath/"$(date +%F)".csv
  echo ""
  echo "########"
  df -h 2>&1 | grep -E "ES_Storage|Filesystem"
else
  echo -e "${LRED} You must be root to run this script ${NC}"
fi
