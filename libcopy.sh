#!/bin/sh

SOURCEROOT=$1
TARGET=$2
shift; shift

echo $*
LIBS=`ldd $* | grep '[0-9a-fA-F] rlib ' | cut -d/ -f2- | sort -u`

echo "-----------------------"
echo $LIBS

for ll in $LIBS ; do 
	lfn=`basename ${ll}`
	[ -f "${TARGET}/${lfn}" ] && continue
	echo "${SOURCEROOT}/${ll} => ${TARGET}/${lfn}"
	cp -p ${SOURCEROOT}/${ll} /tmp/{$lfn}
	strip /tmp/{$lfn}
	cp -p /tmp/{$lfn} ${TARGET}/${lfn}
done

