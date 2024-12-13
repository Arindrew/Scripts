#!/bin/bash

# Create destination directory for log output
if [[ ! -d /mnt/NAS/DalimUsers/ADMIN/log/dalim/$HOSTNAME ]]; then
  mkdir -p /mnt/NAS/DalimUsers/ADMIN/log/dalim/$HOSTNAME
fi

# Log output location
LOG=/mnt/NAS/DalimUsers/ADMIN/log/dalim/$HOSTNAME/$(date +%F)_Prepare-000_PoD_Ingest.log
scratchFile=/tmp/pod_ingest
searchDirectory=/mnt/NAS/ctptransfer/PoD/

# Use this find for testing purposes
#find /export/home/sasysask/bin/ingest/ -name "*.xml" > ${scratchFile}

# Use this find for production purposes
printf '%s' "Finding XML files within ${searchDirectory}... "
find $searchDirectory -name "*.xml" > ${scratchFile}
printf '%s\n' "done."

# These double parenthesis are to capture the whole script into a log file,
# specified just after the first closing parenthesis.

((
###
# This function will iterate through the scratchFile and look for any millimeter measurements
# in each XML and add an inch measurement on the succeeding line.
###
function get_pdf_size {
  while IFS='/' read -r blank mnt nas ctptransfer pod series nrn file; do
    fullPath=/$mnt/$nas/$ctptransfer/$pod/$series/$nrn/$file
    # If SizeIN_Height or SizeIN_Width is already in the file, skip doing it again
    if ! grep -q "POD_PDF_SIZE" $fullPath; then
      series=${file:0:5}
      extPDF=${file%.*}
      finalPDF=/mnt/NAS/ctptransfer/PoD/$series/$nrn/"$extPDF".pdf
      pdfSize=$(stat --format=%s "$finalPDF")
      if [[ -z $pdfSize ]]; then
        printf '%s\n' "POD_PDF_SIZE of $finalPDF is empty. Skipping..."
      else
        sed -i "\$i<TwistTable key=\"POD_PDF_SIZE\" value=\"$pdfSize\"/>" $fullPath
        printf '%s\n' "Adding POD_PDF_SIZE ($pdfSize) of "$extPDF".pdf to $fullPath"
      fi
    fi
  done < ${scratchFile}
}

###
# This function will search through the directory for XML files and look for any
# millimeter measurements and add an inch measurement on the succeeding line.
###
function mm_to_inch {
  while IFS='/' read -r blank mnt nas ctptransfer pod series nrn file; do
    fullPath=/$mnt/$nas/$ctptransfer/$pod/$series/$nrn/$file
    # If SizeIN_Height or SizeIN_Width is already in the file, skip doing it again
    if ! grep -q "SizeIN_Height\|SizeIN_Width" $fullPath; then
      # Convering millimeter height to inches
      heightMM=$(grep SizeMM_Height $fullPath | cut -d'"' -f6)
      heightIN=$(echo "scale=2;$heightMM*0.0394/1" | bc)
      #sed -i 's/SizeMM_Height/SizeIN_Height/g' $line
      #sed -i "s/$heightMM/$heightIN/g" $line
      sed -i "/SizeMM_Height/a<TwistTable key=\"Document,SizeIN_Height\" label=\"SizeIN_Height\" value=\"$heightIN\">" $fullPath

      # Convering millimeter width to inches
      widthMM=$(grep SizeMM_Width $fullPath | cut -d'"' -f6)
      widthIN=$(echo "scale=2;$widthMM*0.0394/1" | bc)
      #sed -i 's/SizeMM_Width/SizeIN_Width/g' $line
      #sed -i "s/$widthMM/$widthIN/g" $line
      sed -i "/SizeMM_Width/a<TwistTable key=\"Document,SizeIN_Width\" label=\"SizeIN_Width\" value=\"$widthIN\">" $fullPath
      printf '%s\n' "Adding Size in inches to $fullPath"
    fi
  done < ${scratchFile}
}

printf '%s' "Running function: get_pdf_size... "
get_pdf_size
printf '%s\n' "done."

printf '%s' "Running function: mm_to_inch... "
mm_to_inch
printf '%s\n' "done."

) 2>&1 >> $LOG)
rm -f $scratchFile
