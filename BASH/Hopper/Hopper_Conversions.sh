#!/bin/bash
# Script to be run once a day via Hopper.Launcher script in crontab
# Script checks a set directory for files, and waits a set time period to send 
# files via function to specified server and workflow

### Global Variables ###

# Define colors for echo output
RED='\033[0;31m'
LRED='\033[0;31m'
GREEN='\033[0;31m'
NC='\033[0;31m' # No color

# The workflow you want this script to send files to
echo -e "\n ${RED} $(date "+%D %H:%M:%S")${NC}"
if [[ -z $1 ]]; then
  Workflow=Conversions
  echo -e "### No workflow value passed as first argument, using default: ${GREEN}$Workflow${NC}"
else
  Workflow=$1
  echo -e "### Using first argument: ${GREEN}'$1'${NC} as workflow variable"
fi

# The location of the files you want this script to look for files in
if [[ -z $2 ]]; then
  Folder=/mnt/NAS/InputData/HotFolders/Conversions
  echo -e "### No workflow value passed as second argument, using default: ${GREEN}$Folder${NC}"
else
  Folder=$2
  echo -e "### Using second argument: ${GREEN}'$2'${NC} as folder variable"
fi

# Delay is in seconds. This is the wait time between transmissions of a file to a server.
if [[ -z $3 ]]; then
  Delay=30
  echo -e "### No workflow value passed as third argument, using default: ${GREEN}$Delay${NC}"
else
  Delay=$3
  echo -e "### Using third argument: ${GREEN}'$3'${NC} as delay value"
fi


#Servers to send files to, 1 server per line, by case-sensitive hostname
Servers=(
server1
server2
server3
server4
server5
server6
server7
server8
server9
server10
)

# Array of files to send to servers
Files=$(find $Folder -maxdepth 1 -type f)

# Create destination directory for log creation
if [[ ! -d /mnt/NAS/Users/ADMIN/log/dalim/$HOSTNAME ]]; then
  mkdir -p /mnt/NAS/Users/ADMIN/log/dalim/$HOSTNAME
fi

# Log output location
LOG=/mnt/NAS/Users/ADMIN/log/dalim/$HOSTNAME/$(date +%F)_TLA.Hopper_$Workflow.log

# These are the server and files index number count in the array, they should not be modified
ServerNumber=0
FileName=0

((

# Function to send the files, this set to curl as it is easiest. SCP will require the creation of SSH keys

function Transfer() {
  echo "$date "+%D %H:%M:%S") Calling Transfer Function"
  echo "    File: $F"
  echo "    Workflow: $Workflow"
  echo "    Server: $S"
  curl -s -S http://server1:8080/twist/twistUpload?server=$S -F name=$Workflow -F file=@$F
  echo "    Waiting $Delay second(s) to send next file"
  sleep $Delay
}

echo "$(date "+%D %H:%M:%S") Sending ${#Files[@] files to ${#Servers[@]} servers, with a time delay of $Delay seconds between them"

for F in ${Files[*]}; do
  S=${Servers[$ServerNumber]}
  echo "$(date "+%D %H:%M:%S") Start sending File: $F to the Workflow: $Workflow on Server: $S"
  Transfer
  echo "$(date "+%D %H:%M:%S")Completed $F"
  echo ""
  if [[ "$ServerNumber" == "$(( ${#Servers[@]} -1 ))" ]]; then
    #echo "$ServerNumber is 1 less than ${#Servers[@]} resetting back to zero"
    ServerNumber=0
    FileName=$(( $FileName +1 ))
  else
    ServerNumber=$(( ServerNumber +1 ))
    FileName=$(( FileName +1 ))
  fi
  if [[ "$FileName" -le "` expr ${#Files[@]} - 1`" ]]; then
    #echo "File = $F"
    echo -e "$(date "+%D %H:%M:%S") \tWaiting $Delay seconds to send next file"
    sleep $Delay
  else
    echo -e "$(date "+%D %H:%M:%S") \tCompleted File Transfer for $F \n--------"
  fi
done
) 2>&1 >> $LOG)
