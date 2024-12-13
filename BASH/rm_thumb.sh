#!/bin/bash

today=/mnt/NAS/Users/ADMIN/log/remove_thumbs/$(date -I)
if [[ ! -d $today ]]; then
    mkdir -p $today
fi

# Easy directories, no ".snapshot" to pointlessly trawl
find /mnt/NAS/archive2/HSM/ -name "Thumbs.db" -print -delete | tee -a "$today"/archive2
find /mnt/NAS//HSM/ -name "Thumbs.db" -print -delete | tee -a "$today"/
find /mnt/NAS/transfer/PoD/ -name "Thumbs.db" -print -delete | tee -a "$today"/transfer_pod
find /mnt/NAS/transfer/GeoRef/ -name "Thumbs.db" -print -delete | tee -a "$today"/transer_georef
find /mnt/NAS/3D_PoD/InputData/ -name "Thumbs.db" -print -delete | tee -a "$today"/3D_PoD_InputData
find /mnt/NAS/3D_PoD/WorkingFiles/ -name "Thumbs.db" -print -delete | tee -a "$today"/3D_PoD_InputData

# Slow directories, will have to trawl through a ".snapshot" directory
find /mnt/NAS/PrintData -name "Thumbs.db" -print -delete 2>/dev/null | tee -a "$today"/PrintData
find /mnt/NAS/InputData -name "Thumbs.db" -print -delete 2>/dev/null | tee -a "$today"/InputData
find /mnt/NAS/WorkingFiles -name "Thumbs.db" -print -delete 2>/dev/null | tee -a "$today"/WorkingFiles
find /mnt/NAS/collarless -name "Thumbs.db" -print -delete 2>/dev/null | tee -a "$today"/collarless
find /mnt/NAS/Users -name "Thumbs.db" -print -delete 2>/dev/null | tee -a "$today"/Users

# Delete empty log files
find $today -size 0 -delete
