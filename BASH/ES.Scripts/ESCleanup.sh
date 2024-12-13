#!/bin/bash

# Set directory variables
DTODir=/mnt/NAS/InputData/HotFolders/DALiM_ES/DTO/
AssemblyDir=/mnt/NAS/InputData/HotFolders/DALiM_ES/Assembly/

# Set log location
today=/mnt/NAS/DalimUsers/ADMIN/log/ES_Hotfolder_cleanup/$(date -I)
if [[ ! -d $today ]]; then
    mkdir -p $today
fi

# Amount of time to wait (in minutes) before moving the files
TimeToWait=30

# Search through the DTO Directory looking for folders that
# are older than the TimeToWait variable and deleting them
touch $DTODir
find $DTODir -type d -mmin +$TimeToWait | while IFS= read -r file; do
    if [ -d "${file}" ]; then
        printf '%s\n' "Folder that is older than 30 minutes: ${file}" | tee -a "$today"/DTOCleanup.log
        rmdir -v ${file} | tee -a "$today"/DTOCleanup.log
    else
        printf '%s\n' "No files found"
    fi
done

# Search through the Assembly Directory looking for folders that
# are older than the TimeToWait variable and deleting them
touch $AssemblyDir
find $AssemblyDir -type d -mmin +$TimeToWait | while IFS= read -r file; do
    if [ -d "${file}" ]; then
        printf '%s\n' "Folder that is older than 30 minutes: ${file}" | tee -a "$today"/AssemblyCleanup.log
        rmdir -v ${file} | tee -a "$today"/AssemblyCleanup.log
    else
        printf '%s\n' "No files found"
    fi
done