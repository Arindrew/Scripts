#!/bin/bash

# This script was primarily written for the project concerning the
# 11_ctptransfer_Cleanup and 12_ctptransfer_Publish TWiST workflows.
#
# 1. Run find command finding all files in `ctptransfer` that are older than
# x many years. Typically with this script:
# /mnt/NAS/DalimUsers/MasterFiles/Master_Scripts\findOldPDFs.sh
# Save the ouput into /root/xxyears_linux.txt
#
# 2. Run this script on the /root/xxyears_linux.txt which will save the output
# into a file called xxyears_windows.txt into your working directory.
#
# 3. Run the following script with the xxyears_linux.txt file as its input:
# /mnt/NAS/DalimUsers/MasterFiles/Master_Scripts/Generic_TWiST_curl_List.sh
# Ensure that the script is configured to send the files to the appropriate 
# TWiST workflow.
#
# 4. Run the Master_Scripts\Generic_TWiST_curl_Hotfolder.sh script with the
# output from the above workflow as its input. Ensure that the script is
# configured to send the files to the appropriate TWiST workflow.
#
# 5. Give Tim Perano the xxyears_windows.txt file for processing.

while read file; do
  trim=$( echo $file | cut -d/ -f 7 )
  echo Y:\\${trim:0:4}\\${trim:0:-4}\\${trim} >> /root/$1_Windows.txt
done < $1
