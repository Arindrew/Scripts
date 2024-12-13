#!/bin/bash

# To get a list of pdfs run:
# find /mnt/NAS/WorkingFiles/Workflows/ZZZ_USGS_SortXML_v3 -iname "*.pdf" > /tmp/IngestList
# where the first location is the files you want to look though, then run this script.

mapfile -t files < /tmp/IngestList
FILENAME=/mnt/NAS/DalimUsers/POD_KellerA/usgsFiles/errorMessage

while read -r file; do
  if [[ $i == *US_*"pdf"* ]]; then
    pdfinfo $i 2>&1 > /mnt/NAS/DalimUsers/POD_KellerA/usgsFiles/errorMessage
    infoOut=$(stat -c%s "$FILENAME" )
    if [[ $infoOut -eq 0 ]]; then
      echo "$i is bad"
      echo $i >> /mnt/NAS/DalimUsers/POD_KellerA/usgsFiles/CantOpenPdfs
    fi
  fi
done < <(find /mnt/NAS/WorkingFiles/Workflows/ZZZ_USGS_SortXML_v3 -iname "*.pdf")
