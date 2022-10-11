#!/bin/bash

# The workflow you want this script to send files to
Workflow=13_Automate_QRCode

# The location of the files you want this script to look for files in
Folder=/mnt/NAS/InputData/18k_PDFs/NotinSpreadsheet/Finished_INPUT_ALREADY

# Delay in seconds, betwee transmissions of a file to the server
Delay=30

# Servers to send files to, 1 server per line, by case-sensitive hostname
Servers=(
server1
server2
server3
server4
server5
server6
server7
server8
)



# Array of files to send to servers
Files=$(find $folder -maxdepth 1 -type f)

# These are the Server File Index Number count in the Array
ServerNumber=0
FileNumber=0

# Function to send filse, this is set to curl as it is easiest. SCP will require the creation of SSH keys

function Transfer() {
  echo "$date "+%D %H:%M:%S") Calling Transfer Function"
  echo "    File: $F"
  echo "    Workflow: $Workflow"
  echo "    Server: $S"
  curl -s -S http://server1:8080/twist/twistUpload?server=$S -F name=$Workflow -F file=@$F
  #rm -rf $F
  echo "    Waiting $Delay second(s) to send next file"
  sleep $Delay
}

for F in ${Files[*]}; do
  S=${Servers[$ServerNumber]}
  Transfer
  echo "$(date "+%D %H:%M:%S") Completed Transfer Function
  echo ""
  if [[ "$ServerNumber" == "$(( ${#Servers[@]} -1 ))" ]]; then
    # $ServerNumber is less than ${#Servers[@]} - resetting back to zero
    ServerNumber=0
    FileNumber=$(( $FileNumber + 1 ))
  else
    ServerNumber=$(( $ServerNumber + 1 ))
    FileNumber=$(( $FileNumber + 1 ))
  fi
done
