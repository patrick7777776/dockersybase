#!/bin/bash
source /opt/sybase/SYBASE.sh

for f in /import/*.csv; do
	b=$(basename $f)
	t=${b%.csv}
	echo Truncating $f
  tail -n 1000 $f > $f.truncated
	echo Importing $f.truncated
  bcp $t in $f.truncated -S TESTSYBASE -U user -P pass -c                                                  
  rm $f.truncated
done
