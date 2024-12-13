#!/bin/bash

LogDir="/mnt/NAS/DalimUsers/ADMIN/log/dalim/$(hostname -f)/"
if [[ ! -d $LogDir ]]; then
  mkdir -p $LogDir
fi

# Delete log files older than 30 days
echo "Removing from /var/log/dalim:" | tee -a /var/log/DTOCleanup/$DateStamp.log
find /var/log/dalim/ -maxdepth 1 -mtime +30 -type f -delete -print | tee -a /var/log/DTOCleanup/$DateStamp.log
echo "" | tee -a /var/log/DTOCleanup/$DateStamp.log

# Delete log files older than 30 days
echo "Removing from DLA_PoD_Report:" | tee -a /var/log/DTOCleanup/$DateStamp.log
find /mnt/NAS/DalimUsers/DLA_PoD_Report -maxdepth 1 -mtime +30 -type f -delete -print | tee -a /var/log/DTOCleanup/$DateStamp.log
echo "" | tee -a /var/log/DTOCleanup/$DateStamp.log

# Delete all files older than 90 days
echo "Removing files from ZZZ_TWiST_Errors:" | tee -a /var/log/DTOCleanup/$DateStamp.log
find /mnt/NAS/WorkingFiles/ZZZ_TWiST_Errors -type f -mtime +90 -delete -print | tee -a /var/log/DTOCleanup/$DateStamp.log
echo "" | tee -a /var/log/DTOCleanup/$DateStamp.log

# Delete all folders that are empty
echo "Removing empty folders from ZZZ_TWiST_Errors:" | tee -a /var/log/DTOCleanup/$DateStamp.log
find /mnt/NAS/WorkingFiles/ZZZ_TWiST_Errors -type d -empty -delete -print | tee -a /var/log/DTOCleanup/$DateStamp.log
echo "" | tee -a /var/log/DTOCleanup/$DateStamp.log
