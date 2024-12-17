#!/bin/bash
#Script to be run once a day via a Hopper.Launcher script in crontab
#Script checks a set directory for files, and waits a set time period to send files via function to specified server and workflow

#Define colors for stdout
function colors_stdout()
{
RED='\033[0;031m'
LRED='\033[1;031m'
GREEN='\033[0;032m'
NC='\033[0m'
}

# The Workflow you want this script to send files to
echo -e "$(date "+%D %H:%M:%S")"
if [[ -z $1 ]]; then
  Workflow=ZZZ_GeoRef_sort
  echo -e "### No Workflow Value passed as first argument, using default: ${GREEN}$Workflow${NC}"
else
  Workflow=$1
  echo -e "### Using first argument: ${GREEN}$1${NC} as Workflow Variable"
fi

#The location of the files you want this script to look for file in
if [[ -z $2 ]]; then
  Folder=/mnt/NAS/InputData/HotFolders/ZZZ_GeoRef_Sort
  echo -e "### No Workflow Value passed as second argument, using default: $Folder$"
else
  Folder=$2
  echo -e "### Using second argument: $2$ as Folder Variable"
fi

#Delay is in seconds, 600 = 10 minutes, 3600 = 1 hour. This is wait time between transmissions of a file to a server.
if [[ -z $3 ]]; then
  Delay=1
  echo -e "### No Workflow Value passed as third argument, using default: $Delay\n"
else
  Delay=$3
  echo -e "### Using third argument: $3 as Delay Value\n"
fi


#Servers to send files to, 1 server per line, by case-sensitive hostname
Servers=(
ndwsstwslpdal08
)

#Array of files to send to servers
Files=$(find "$Folder" -maxdepth 1 -type f)

#Create destination directory for log creation
today=/mnt/NAS/DalimUsers/ADMIN/log/Hopper/$(date -I)
if [[ ! -d $today ]]; then
    mkdir -p "$today"
fi

#These are the Server and File Index number count in the Array
ServerNumber=0
FileName=0

((

#Function to send the files, this set to curl as it is easiest. scp will require the creation of ssh keys

function Transfer() {
  echo "$(date "+%D %H:%M:%S") Calling Transfer Function"
  echo "    File: $F"
  echo "    Workflow: $Workflow"
  echo "    Server: $S"
  curl -s -S http://"$S":8080/twist/twistUpload?server="$S" -F name="$Workflow" -F file="@$F"
  echo "    Waiting $Delay second(s) to send next file"
  sleep "$Delay"
  rm -rf "$F"
}

echo "$(date "+%D %H:%M:%S") :Sending ${#Files[@]} files to ${#Servers[@]} servers, with a time delay of $Delay seconds between them"

for F in ${Files[*]}; do
  S=${Servers[$ServerNumber]}
  echo "$(date "+%D %H:%M:%S") Start sending File: $F to the Workflow: $Workflow on Server: $S"
  Transfer
  echo "$(date "+%D %H:%M:%S") Completed $F"
  echo ""
  if [[ "$ServerNumber" == "$(( ${#Servers[@]} - 1 ))" ]]; then
    #echo "$ServerNumber is 1 less than  ${#Servers[@]} reseting back to zero"
    ServerNumber=0
    FileName=$(( FileName + 1 ))
  else
    ServerNumber=$(( ServerNumber + 1 ))
    FileName=$(( FileName + 1 ))
  fi
  if [[ "$FileName" -le "` expr ${#Files[@]} - 1`" ]]; then
    #echo "File = $F"
    echo -e "$(date "+%D %H:%M:%S") \tWaiting $Delay seconds to send next file"
    sleep "$Delay"
  else
    echo -e "$(date "+%D %H:%M:%S") \tCompleted File Transfer for $F \n--------"
  fi
done
) 2>&1 >> "$today"/NGA.Hopper_"$Workflow".log)

colors_stdout
