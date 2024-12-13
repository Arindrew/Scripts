#!/bin/bash

### Usage
# /bin/bash /path/to/this/script.sh /path/to/file.pdf /path/to/output/file.xml

LD_LIBRARY_PATH=/usr/lib64
sleep 5

# Extract page size of PDF using the pdfinfo tool
pdfHeight_pts=$(/usr/bin/pdfinfo $1 | grep "Page size" | cut -d" " -f8)
pdfWidth_pts=$(/usr/bin/pdfinfo $1 | grep "Page size" | cut -d" " -f10)

# Convert the "pts" value from the pdfinfo tool to inches
Print_Height=$(echo "scale=2;$pdfHeight_pts/72" | bc)
Print_Width=$(echo "scale=2;$pdfWidth_pts/72" | bc)

# Get the size of the PDF specified via the command
pdfSize=$(stat --format=%s $1)

# Being outputting all the metadata to the associated XML (specified via the command)
printf '%s\n' "<PDF_Sizes>" >> $2
printf '%s\n' "  <Print_Height>$Print_Height</Print_Height>" >> $2
printf '%s\n' "  <Print_Width>$Print_Width</Print_Width>" >> $2
printf '%s\n' "  <File_Size>$pdfSize</File_Size>" >> $2
printf '%s\n' "</PDF_Sizes>" >> $2
# End outputting all the metadata
