#!/bin/bash
#this should reside on the ES Twist server in /symlnks/var/6.0/scripts folder
# DisplayName = TEST SCRIPT
# Arguments = Arg1
# Arg1.Type = InputFile
InputFile="$1"
LOG=/tmp/es_script.log
echo "$InputFile" >> $LOG

GenDate=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $1 }')
echo ESResult:MetaData/:NGAProduction/GenDate="$GenDate"

MiscInfo=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $2 }')
echo ESResult:MetaData/:NGAProduction/MiscInfo="$MiscInfo"

NRN=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $3 }')
echo ESResult:MetaData/:NGAProduction/NRN="$NRN"

Edition=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $4 }')
echo ESResult:MetaData/:NGAProduction/Edition="$Edition"

Classification=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $5 }')
echo ESResult:MetaData/:NGAProduction/Classification="$Classification"

ControlRelease=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $6 }')
echo ESResult:MetaData/:NGAProduction/ControlRelease="$ControlRelease"

LIMDISNote=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $7 }')
echo ESResult:MetaData/:NGAProduction/LIMDISNote="$LIMDISNote"

SpecialNotes=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $8 }')
echo ESResult:MetaData/:NGAProduction/SpecialNotes="$SpecialNotes"

Priority=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $9 }')
echo ESResult:MetaData/:NGAProduction/Priority="$Priority"

R4D=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $10 }')
echo ESResult:MetaData/:NGAProduction/R4D="$R4D"

GEOPOLCode=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $11 }')
echo ESResult:MetaData/:NGAProduction/GEOPOLCode="$GEOPOLCode"

Command=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $12 }')
echo ESResult:MetaData/:NGAProduction/Command="$Command"

NSN=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $13 }')
echo ESResult:MetaData/:NGAProduction/NSN="$NSN"

StatusLocation=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $14 }')
echo ESResult:MetaData/:NGAProduction/StatusLocation="$StatusLocation"

StatusDate=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $15 }')
echo ESResult:MetaData/:NGAProduction/StatusDate="$StatusDate"

ProjectCode=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $16 }')
echo ESResult:MetaData/:NGAProduction/ProjectCode="$ProjectCode"

RequestorInfo=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $17 }')
echo ESResult:MetaData/:NGAProduction/RequestorInfo="$RequestorInfo"

SeriesNumber=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $18 }')
echo ESResult:MetaData/:NGAProduction/SeriesNumber="$SeriesNumber"

Sheet=$(cat $InputFile | awk 'BEGIN {FS="^"}{print $19 }')
echo ESResult:MetaData/:NGAProduction/Sheet="$Sheet"