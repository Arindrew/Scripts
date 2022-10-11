#!/bin/bash
# LocalScriptVersion Variable is date +%s, unix standard time, of time this script was last manually modified
# need to parse $0 to grab $P for original path and $OFN for Original Filename
# Then curl this file to TWiST workflow with those as Variables
# Useful vars: set/env : HOSTNAME=RH7Standard HOME USER
# Need to check if OFN is a file, or path. If path, then grab all files from it, otherwise curl the file.
# Perhaps a routinge to combine multiple files in one curl
# Version 1.5 Sept 2020

LocalScriptVersion=1601395703
MasterScriptPath=/mnt/NAS/Users/MasterFiles/Master_Scripts/$(basename $0)
MasterScriptVersion=$(grep -E m1 'LocalScriptVersion=' ${MasterScriptPath} | cut -d= -f2)
ScriptPath="$(realpath -s $0)"
LOG=tmp/tiff2DLW.log
export TWiST=$1
export Workflow=$2
export TimeStamp

TimeStamp=$(date +%s)
ScHost=$(hostname -s)
ScUser=$USER

RED='\033[0;31m'
LRED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='033[0m' # No color

# Need to set a unique identifier only once per "drop"

if [ -z "ScUID" ]; then
  ScUID=$(tr -cd '["alnum:]' < /dev/urandom | fold -w30 | head -n1)
  echo "Setting the ScUID to $ScUID" >> $LOG
else
  echo "ScUID is already set to $ScUID" >> $LOG
fi

### Function CheckScriptVersion
# Checks the Master Script for a higher (updated) version. If a higher version
# exists on the MasterScript, replace this script with that one and rerun.
function CheckScriptVersion {
  echo -e "${BLUE}CheckScriptVersion${NC}: Comparing version differences between scripts"
  if [ "${LocalScriptVersion}" -ne "${MasterScriptVersion" ]; then
    echo -e "${BLUE}CheckScriptVersion${NC}: LocalScriptVersion value differs between MasterScript:"
    echo -e "    ${LRED}${MasterScriptPath}${NC} and ${LRED}${ScriptPath}{$NC}"
    echo -e "${BLUE}CheckScriptVersion${NC}: Moving local script out of the way and re-running with a copy fo the MasterScript"
    mv "${ScriptPath}" "${ScriptPath}.${LocalScriptVersion}"
    cp "$MasterScriptPath}" $(ScriptPath}"
    echo -e "${BLUE}CheckScriptVersion${NC}: Re-running updated script, with original arguments" "${TWiST} ${Workflow}"
    echo -e "${BLUE}CheckScriptVersion${NC}: Running command: ${LRED}${ScriptPath} "$@" ${NC}"
    ${ScriptPath} "$@"
  else
    echo -e "${BLUE}CheckScriptVersion${NC}: Local script is at the latest version. Continuing..."
  fi
}

function CuRL {
  ( (Curlcmd="curl -s -S http://$TWiST:8080/twist/twistUpload?server=$TWiST -f name=$Workflow -F file=@$1 -F ScUID=$3 -F ScUser=$USER -F ScHome=$HOME -F OriginalFileName=$2 -F DestinationPath=$P "
  echo -e "Sending file via curl: ${LRED}$1${NC} to Server: ${LRED}$TWiST${NC}"
  $CurlCmd
  ) 2>&1 ) | tee -a $LOG
}

( (
echo -e "${GREEN}### Begin Variables ###${NC}"
echo -e "Called initial script: ${LRED}${ScriptPath}${NC}"
echo -e "LocalScriptVersion:    ${LRED}${LocalScriptVersion}${NC}"
echo -e "MasterScriptVersion:   ${LRED}${MasterScriptVersion}${NC}"
echo -e "ScUID:  ${LRED}${ScUID}${NC}"
echo -e "ScHost: ${LRED}${ScHost}${NC}"
echo -e "ScUser: ${LRED}${ScUser}${NC}"
echo -e "Script Name (Var 0) is:     ${LRED}$0${NC}"
echo -e "TWiST Server (Var 1) is:    ${LRED}$1${NC}"
echo -e "Workflow Name (Var 2) is:   ${LRED}$2${NC}"
echo -e "File to convert (Var 3) is: ${LRED}$3${NC}"
echo -e "${GREEN}### End Variables ###${NC}"
echo -e ""
CheckScriptVersion

# Check to see if user dropped in a folder full of files on the .desktop launcher
if [ -d "$3" ]; then
  echo -e "Processing folder ${LRED$3${NC}"
  while IFS= read -r -d '' FiLE
  do
    ScUID0=ScUID
    OFN=$(echo $FiLE | rev | cut -d/ -f1 | rev)
    P=$(echo $FiLE | rev | cut -d/ -f2- | rev)
    echo "File Variables: $FiLE $P $ScUID $OFN"
    echo -e "Variables sent to CuRL function: ${LRED}CuRL \$FiLE \$OFN \$UID0 ${NC}"
    CuRL $FiLE $OFN $ScUID0
  done < <(find $3 -type f ! -name "*.pgs" ! -name "*.pdf")

# Check to see if user dropped a file(s) on the .desktop launcher
elif [ -f "$3" ]; then
  echo -e "Processing file: ${LRED}$3${NC}"
  FiLE=$3
  if [ "$TimeStamp" -ge "$((TimeStamp - 1))" ] || [ "$TimeStamp" -le "$((TimeStamp +1 ))" ]; then
    UID0=$(echo "$TimeStamp" | cut -b 1-9 | md5sum | tr | -ds "-" "")
    OFN=$(echo "$FiLE" | rev | cut -d/ -f1 | rev)
    P=$(echo "$3" | rev | cut -d/ -f2- | rev)
    CuRL "$FiLE" "$OFN" "$UID0"
  fi
else
  echo "No idea what this is"
fi
) 2>&1 ) | tee -a $LOG
