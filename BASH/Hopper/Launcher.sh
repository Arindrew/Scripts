#!/bin/bash

################################################################################
#  Script to be called via crontab to launch all Hopper scripts                #
#  Script will look in default directory for all scripts named:                #
#    NGA.Hopper_WorkflowName.sh                                                #
#  Will check if script is running, if found running skip initiating.          #
################################################################################

#Define colors for stdout
function colors_stdout()
{
RED='\033[0;031m'
LRED='\033[1;031m'
GREEN='\033[0;032m'
NC='\033[0m'
}

#Directory to check for Hopper Scripts to run
Scripts=/mnt/NAS/DalimUsers/MasterFiles/Master_Scripts/SecNet_Master_Hopper/

#Directory to check for files, must be named to match workflow name, exactly
Directory=/mnt/NAS/InputData/HotFolders/Master_Hopper

#Create destination directory for log creation
today=/mnt/NAS/DalimUsers/ADMIN/log/Hopper/$(date -I)
if [[ ! -d $today ]]; then
    mkdir -p "$today"
fi

#NGA_Hopper scripts can use 3 arguments:
#$1 Workflow Name
#$2 Directory containing files
#$3 Time Delay between sending files

((
cd "$Scripts" || exit
#for S in $( ls NGA.Hopper_*.sh ); do
for S in NGA.Hopper_*.sh; do 
  Workflow=$( find "$S" | cut -d_ -f2-99 | rev | cut -b 4-99 | rev )
  if [[ -d "$Directory/$Workflow" ]]; then
    echo -e "${GREEN}$(date "+%D %H:%M:%S")${NC}"
    echo "### Checking for scripts, found these scripts to start:"
    find "$Scripts" -name "NGA.Hopper*.sh" | awk -F / '{print $NF}'
    if [[ "$(pgrep -c "$S")" -ge "1" ]]; then
      echo -e "The Script $S is running, will not start script, will check next cycle\n"
    else
      #Run custom sub routines for Conversions and NOAA, all other scripts treated the same
      #Variables: $Workflow = parsed from script name, does not match TWiST workflow, but must match foldername
      #SubDir : subdirectory in the above folder
      if [[ "$Workflow" = "Conversions" ]]; then
        #need to add special routine to list directorys in  $Directory/Conversions, treat those as workflows
        for SubDir in $(find $Directory/"$Workflow" -maxdepth 1 -type d | awk -F / '{print $NF}'); do
          echo -e ""
          echo -e "Calling SubDir sub-routine..."
          echo -e "  Script: $S"  
          echo -e "  Workflow: $SubDir"  
          echo -e "  Directory: $Directory/$Workflow/$SubDir"
          if [[ "$Directory/$Workflow/$SubDir" = "/mnt/NAS/InputData/HotFolders/Master_Hopper/Conversions/Conversions" ]]; then
            echo "  NOT calling Script for root of $Workflow folder"
          else
            /bin/bash "$Scripts"/"$S" "$SubDir" "$Directory"/"$Workflow"/"$SubDir" & 
          fi
        done  
        elif [[ "$(echo "$Workflow" | grep -ci NOAA)" -ge "1" ]]; then
          # Sub routine for NOAA scripts, currently runs only on Saturday, every cron time, need to runs 1 time only on Saturday 00:00
          if [[ "$(date +"%A")" = "Saturday" ]]; then
            echo -e "\n Calling NOAA Scripts on $(date +%A) : $Scripts$S : $Workflow : $Directory/$Workflow"
            /bin/bash "$Scripts"/"$S" "$Workflow" "$Directory"/"$Workflow" &
          else
            echo -e "It's not Saturday, not calling $S \n"
          fi
        else
          echo -e "\n### Calling: \n  Script: $Scripts/$S \n  Workflow: $Workflow \n  Directory: $Directory/$Workflow"
          /bin/bash "$Scripts"/"$S" "$Workflow" "$Directory"/"$Workflow" &
        fi
      fi
    else
  echo "$Directory/$Workflow does not exist, not calling Script: $S"
  fi
done
) 2>&1 >> $today/NGA.Hopper_Launcher.log)

colors_stdout
