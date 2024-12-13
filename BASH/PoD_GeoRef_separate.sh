#!/bin/bash

########
# Variable Declarations
########

#Create destination directory for log retention
today=/mnt/NAS/DalimUsers/ADMIN/log/PoD_GeoRef/$(date -I)
if [[ ! -d /mnt/NAS/DalimUsers/ADMIN/log/PoD_GeoRef/$(date -I) ]]; then
    mkdir -p /mnt/NAS/DalimUsers/ADMIN/log/PoD_GeoRef/$(date -I)
fi

# All ctptransfer files to be moved
fullList="fullList.txt"
# Files that will contain PoD files
podFiles="podFiles.txt"
podMove="podMove.txt"
# Files that will contain GeoRef files
geoFiles="geoFiles.txt"
geoMove="geoMove.txt"

########
# Find all legible files
########

printf '%s\n' "Working folder:                    $today"
# Compile list of files in all of ctptransfer that are currently in a series folder. Crisis, Automated,
# USGS, etc. will not be in this list. Symbolic links are filtered out via the "! -type l" option.
printf '%s\n' "Creating list of files to move:    $(basename $fullList)"
find /mnt/NAS/ctptransfer -regextype posix-egrep -path "/mnt/NAS/ctptransfer/.snapshot" -prune -o ! -type l \
-regex "\/mnt\/NAS\/ctptransfer\/[A-Z0-9_]{5}\/[[:alnum:]]{0,17}_[0-9]{3}\/.*" \
| grep -v ".snapshot" | sort > $today/$fullList


########
# PoD file processing
########

# Process $fullList and grep for lines that do NOT have _geo, output those lines into $podFiles.
printf '%s\n' "Creating PoD file list:            $(basename $podFiles)"
grep -v "_geo" $today/$fullList >> $today/$podFiles

# Process each line from above command and create a move statement. Output a move statement to $podMove for later
# processing. Also output a link statement incase we choose to link to the new file location from the old directory.
printf '%s' "Moving PoD files..."
while IFS='/' read -r blank mnt nas ctptransfer series nrn filename; do
    podSource="/mnt/NAS/ctptransfer/$series/$nrn"
    podDestination="/mnt/NAS/ctptransfer/PoD/$series/$nrn"
    mkdir -p "$podDestination"
    chown daltomcat.dalim "$podDestination"
    chmod 775 "$podDestination"
    mv "$podSource/$filename" "$podDestination"
    ln -s "../../PoD/$series/$nrn/$filename" "$podSource/$filename"
done < $today/$podFiles
printf '%s\n' "                done."

########
# GeoRef file processing
########

# Process $fullList and grep for lines that have _geo, ouput those lines into $geoFiles.
printf '%s\n' "Creating GeoRef file list:         $(basename $geoFiles)"
grep "_geo" $today/$fullList >> $today/$geoFiles

# Process each line from above command and create a move statement. Output a move statement to $geoMove for later
# processing. Also output a link statement incase we choose to link to the new file location from the old directory.
printf '%s' "Moving GeoRef files..."
while IFS='/' read -r blank mnt nas ctptransfer series nrn filename; do
    geoSource="/mnt/NAS/ctptransfer/$series/$nrn"
    geoDestination="/mnt/NAS/ctptransfer/GeoRef/$series/$nrn"
    mkdir -p "$geoDestination"
    chown daltomcat.dalim "$geoDestination"
    chmod 775 "$geoDestination"
    mv "$geoSource/$filename" "$geoDestination"
    ln -s "../../GeoRef/$series/$nrn/$filename" "$geoSource/$filename"
done < $today/$geoFiles
printf '%s\n' "             done."
