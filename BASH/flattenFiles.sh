#/bin/bash 
ctp="/mnt/NAS/ctptransfer/PoD/"
cd $*
for filename in *; do
  echo $filename
  series=${filename:0:5}
  nrn=${filename:0:-4}
  echo $series
  echo $nrn
  destination=${ctp}${series}/${nrn}/${nrn}_flat.pdf
  echo $destination
  /usr/bin/pdf2ps ./"$filename" - | ps2pdf - /tmp/"${nrn}_flat.pdf"
  mv /tmp/"${nrn}_flat.pdf" $destination
  rm $filename
done
