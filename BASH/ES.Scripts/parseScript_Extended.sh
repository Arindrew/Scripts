#!/bin/bash

# This file should reside on the ES Twist server in:
# /symlnks/var/6.0/scripts
#

InputFile="$1"
LOG=/tmp/parse_script_extended.log
echo "$InputFile" >> $LOG

# Cell Column A
NRN=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $1 }')
echo ESResult:MetaData/:STPextended/NRN="$NRN"

# Cell Column B
Series=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $2 }')
echo ESResult:MetaData/:STPextended/Series="$Series"

# Cell Column C
Sheet=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $3 }')
echo ESResult:MetaData/:STPextended/Sheet="$Sheet"

# Cell Column D
NSN=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $4 }')
echo ESResult:MetaData/:STPextended/NSN="$NSN"

# Cell Column E
Edition=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $5 }')
echo ESResult:MetaData/:STPextended/Edition="$Edition"

# Cell Column F
ScaleCode=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $6 }')
echo ESResult:MetaData/:STPextended/ScaleCode="$ScaleCode"

# Cell Column G
ScaleNumber=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $7 }')
echo ESResult:MetaData/:STPextended/ScaleNumber="$ScaleNumber"

# Cell Column H
GEN=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $8 }')
echo ESResult:MetaData/:STPextended/GEN="$GEN"

# Cell Column I
GENC2=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $9 }')
echo ESResult:MetaData/:STPextended/GENC2="$GENC2"

# Cell Column J
GENC3=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $10 }')
echo ESResult:MetaData/:STPextended/GENC3="$GENC3"

# Cell Column K
GENC3_All=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $11 }')
echo ESResult:MetaData/:STPextended/GENC3_All="$GENC3_All"

# Cell Column L
AOR_Command=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $12 }')
echo ESResult:MetaData/:STPextended/AOR_Command="$AOR_Command"

# Cell Column M
SheetName=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $13 }')
echo ESResult:MetaData/:STPextended/SheetName="$SheetName"

# Cell Column N
Complexity=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $14 }')
echo ESResult:MetaData/:STPextended/Complexity="$Complexity"

# Cell Column O
Product=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $15 }')
echo ESResult:MetaData/:STPextended/Product="$Product"

# Cell Column P
MapFlavor=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $16 }')
echo ESResult:MetaData/:STPextended/MapFlavor="$MapFlavor"

# Cell Column Q
SourceData=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $17 }')
echo ESResult:MetaData/:STPextended/SourceData="$SourceData"

# Cell Column R
Projection=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $18 }')
echo ESResult:MetaData/:STPextended/Projection="$Projection"

# Cell Column S
Datum=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $19 }')
echo ESResult:MetaData/:STPextended/Datum="$Datum"

# Cell Column T
SW_DD_Lon=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $20 }')
echo ESResult:MetaData/:STPextended/SW_DD_Lon="$SW_DD_Lon"

# Cell Column U
SW_DD_Lat=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $21 }')
echo ESResult:MetaData/:STPextended/SW_DD_Lat="$SW_DD_Lat"

# Cell Column V
NE_DD_Lon=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $22 }')
echo ESResult:MetaData/:STPextended/NE_DD_Lon="$NE_DD_Lon"

# Cell Column W
NE_DD_Lat=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $23 }')
echo ESResult:MetaData/:STPextended/NE_DD_Lat="$NE_DD_Lat"

# Cell Column X
Language=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $24 }')
echo ESResult:MetaData/:STPextended/Language="$Language"

# Cell Column Y
PrimaryProducer=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $25 }')
echo ESResult:MetaData/:STPextended/PrimaryProducer="$PrimaryProducer"

# Cell Column Z
SecondaryProducer=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $26 }')
echo ESResult:MetaData/:STPextended/SecondaryProducer="$SecondaryProducer"

# Cell Column AA
SecClass=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $27 }')
echo ESResult:MetaData/:STPextended/SecClass="$SecClass"

# Cell Column AB
SecRelease=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $28 }')
echo ESResult:MetaData/:STPextended/SecRelease="$SecRelease"

# Cell Column AC
CurrDateType=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $29 }')
echo ESResult:MetaData/:STPextended/CurrDateType="$CurrDateType"

# Cell Column AD
CurrencyDate=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $30 }')
echo ESResult:MetaData/:STPextended/CurrencyDate="$CurrencyDate"

# Cell Column AE
CopyrightDate=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $31 }')
echo ESResult:MetaData/:STPextended/CopyrightDate="$CopyrightDate"

# Cell Column AF
ProjectGroupName=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $32 }')
echo ESResult:MetaData/:STPextended/ProjectGroupName="$ProjectGroupName"

# Cell Column AG
ContactEmail=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $33 }')
echo ESResult:MetaData/:STPextended/ContactEmail="$ContactEmail"

# Cell Column AH
Layered=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $34 }')
echo ESResult:MetaData/:STPextended/Layered="$Layered"

# Cell Column AI
Attributed=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $35 }')
echo ESResult:MetaData/:STPextended/Attributed="$Attributed"

# Cell Column AJ
ST_Priority=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $36 }')
echo ESResult:MetaData/:STPextended/ST_Priority="$ST_Priority"

# Cell Column AK
ST_Status=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $37 }')
echo ESResult:MetaData/:STPextended/ST_Status="$ST_Status"

# Cell Column AL
Print_Height=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $38 }')
echo ESResult:MetaData/:STPextended/Print_Height="$Print_Height"

# Cell Column AM
Print_Width=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $39 }')
echo ESResult:MetaData/:STPextended/Print_Width="$Print_Width"

# Cell Column AN
PoD_PDF_Size=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $40 }')
echo ESResult:MetaData/:STPextended/PoD_PDF_Size="$PoD_PDF_Size"

# Cell Column AO
ST_Acknowledgement_Date=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $41 }')
echo ESResult:MetaData/:STPextended/ST_Acknowledgement_Date="$ST_Acknowledgement_Date"

# Cell Column AP
PoD_Publish_Date=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $42 }')
echo ESResult:MetaData/:STPextended/PoD_Publish_Date="$PoD_Publish_Date"

# Cell Column AQ
ST_Miscellaneous_Info=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $43 }')
echo ESResult:MetaData/:STPextended/ST_Miscellaneous_Info="$ST_Miscellaneous_Info"

