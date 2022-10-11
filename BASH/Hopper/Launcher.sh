#!/bin/bash

################################################################################
# Script will be called via crontab to launch all Hopper scripts
# Script will look into default directory for all scripts named:
#  TLA.Hopper_WorkflowName.sh
# Will check if script is running, if found running will skip initiating
################################################################################

### Global Variables ###

# Define colors for echo output
RED='\033[0;31m'
LRED='\033[1;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No color

# Directory to check for Hopper Scripts to run
Scripts=/mnt/NAS/Users/MasterFiles/Master_Scripts/Hopper/

# Directory to check for files, must be named to match workflow name, exactly
Directory=/mnt/NAS/InputData/HotFolders/Hopper/

# Create destination directory for log creation
if [[ ! -d /mnt/NAS/Users/ADMIN/log/dalim/$HOSTNAME ]]; then
  mkdir -p /mnt/NAS/Users/ADMIN/log/dalim/$HOSTNAME
fi

# Log output location
LOG=//mnt/NAS/Users/ADMIN/log/dalim/$HOSTNAME/$(date +%F)_TLA.Hopper.Launcher.log

# TLA_Hopper scripts can use 3 arguments:
#  $1 Workflow name
#  $2 Directory containing files
#  $3 Time Delay between sending files

((
cd $Scripts
# for S in $( ls TLA.Hopper_*.sh ); do
for S in TLA.Hopper_*.sh; do
  Workflow=$( ls $S | cut -d\_ -f2-99 | rev | cut -b 4-99 | rev )
  if [[ -d "$Directory/$Workflow" ]]; then
    echo -e "${GREEN}$(date "+%D %H:HM:%S")${NC}"
    echo "### Checking for scripts, found these scripts to start:"
    echo "$(find "$Scripts" -name "TLA.Hopper*.sh" | awk -F / '{print $NF}')"
    if [[ "$(ps -ef | grep $S | egrep -cv 'grep | tail -f')" -ge "1" ]]; then
      echo -e "The Script $S is running, will not start script, will check next cycle\n"
    else
      # Run custom routines for Conversions and NOAA, all other scripts will be treated the same
      # Variables: $Workflow = parsed from script name, does not match TWiST workflow, but must match foldername
      # SubDir : subdirectory in the above folder
      if [[ "$Workflow" = "Conversions" ]]; then
        # need to add special routine to list directories in $Directory/Conversions, terat those as workflows
        for SubDir in $(find $Directory/$Workflow -maxdepth 1 -type d | awk -F / '{print $NF}'); do
          echo -e ""
          echo -e "Calling SubDir sub-routine..."
          echo -e "Script: $S"
          echo -e "Workflow: $SubDir"
          echo -e "Directory: $Directory/$Workflow/$Subdir"
          if [[ "$Directory/$Workflow/$Subdir" = "/mnt/NAS/InputData/Hotfolders/Hopper/Conversions/Conversions" ]]; then
            echo "  NOT calling script for root of $Workflow folder"
          else
            /bin/bash $Scripts/$S $SubDir $Directory/$Workflow/$SubDir &
          fi
        done
        elif [[ "$(echo $Workflow | grep -ci NOAA)" -ge "1" ]]; then
          # sub-routine for NOAA scripts, currently runs only on Saturday, every cron time, need to runs 1 time only on Saturday at 00:00
          if [[ "$(date +"%A")" == "Saturday" ]]; then
            echo -e "\n Calling NOAA Scripts on $(date +%A) : $Scripts/$S : $Workflow : $Directory/$Workflow"
            /bin/bash $Scripts/$S $Workflow $Directory/$Workflow &
          else
            echo -e "It's not Saturday, not calling $S \n"
          fi
        else
          echo -e "\n### Calling: \n  Script: $Script/$S \n   Workflow: $Workflow \n   Directory: $Directory/$Workflow"
          /bin/bash $Scripts/$S $Workflow $Directory/$Workflow &
        fi
      fi
    else
  echo "$Directory/$Workflow does not exist, not calling Script: $S"
  fi
done
) 2>&1 >> $LOG)
