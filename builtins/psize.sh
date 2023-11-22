#! /bin/sh
#
# psize.sh -- determine this system's pipe size, and write a define to
#             pipesize.h so ulimit.c can use it.

: ${TMPDIR:=/tmp}
# try to use mktemp(1) if the system supports it
{ TMPFILE="`mktemp $TMPDIR/pipsize.XXXXXX 2>/dev/null`"; } 2>/dev/null
used_mktemp=true

if [ -z "$TMPFILE" ]; then
	TMPNAME=pipsize.$$
	TMPFILE=$TMPDIR/$TMPNAME
	used_mktemp=false
fi

trap 'rm -f "$TMPFILE" ; exit 1' 1 2 3 6 15
trap 'rm -f "$TMPFILE"' 0

echo "/*"
echo " * pipesize.h"
echo " *"
echo " * This file is automatically generated by psize.sh"
echo " * Do not edit!"
echo " */"
echo ""

#
# Try to avoid tempfile races.  We can't really check for the file's
# existence before we run psize.aux, because `test -e' is not portable,
# `test -h' (test for symlinks) is not portable, and `test -f' only
# checks for regular files.  If we used mktemp(1), we're ahead of the
# game.
#
$used_mktemp || rm -f "$TMPFILE"

psize.aux 2>"$TMPFILE" | sleep 3

if [ -s "$TMPFILE" ]; then
	echo "#define PIPESIZE `cat "$TMPFILE"`"
else
	echo "#define PIPESIZE 512"
fi

exit 0
