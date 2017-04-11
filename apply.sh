#!/bin/sh

PDIR=`dirname $0`
SRC=$1
DEST=$2

BSPATCH=`which bspatch`

usage() {
	echo "Usage: $0 <src> <dest>"
	echo "The source path should be an unmodified copy of AirPort Utility 5.6.1"
	echo "Download from https://support.apple.com/kb/dl1536?locale=en_US"
	echo "(Extract 'AirPort Utility.app' using Pacifist, or from the command line using cpio)"
}


if [ -z "${BSPATCH}" ]; then
	echo "Could not find bsdiff/bspatch in your current PATH"
	echo "Install via MacPorts, Homebrew, or directly from http://www.daemonology.net/bsdiff/"
	exit 1
fi

if [ -z "${SRC}" ] || [ -z "${DEST}" ]; then
	usage
	exit 1
fi

rsync -a "${SRC}/" "${DEST}"
"${BSPATCH}" "${SRC}/Contents/Info.plist" "${DEST}/Contents/Info.plist" "${PDIR}/Info.plist.bsdiff"
"${BSPATCH}" "${SRC}/Contents/MacOS/AirPort Utility" "${DEST}/Contents/MacOS/AirPort Utility" "${PDIR}/AirPort Utility.bsdiff"