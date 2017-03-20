#!/bin/bash
#
anz=125
length=9
passwords=""
fileName=$1
#
for i in $(seq 1 "${anz}") ; do
	passwords="${passwords}""$i $(dd if=/dev/urandom bs=1 count=${length} 2> /dev/null | base64 | sed -e 's/\//\\\//g')"'\\\\'
done
sed "s/<PASSWORDS>/${passwords}/" "${fileName}Template" > "${fileName}".tex
