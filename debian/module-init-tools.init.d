#! /bin/sh
### BEGIN INIT INFO
# Provides:          module-init-tools
# Required-Start:
# Required-Stop:
# Should-Start:      checkroot
# Should-stop:
# Default-Start:     S
# Default-Stop:
# Short-Description: Process /etc/modules.
# Description:       Load the modules listed in /etc/modules.
### END INIT INFO
#
# skeleton	example file to build /etc/init.d/ scripts.
#		This file should be used to construct scripts for /etc/init.d.
#
#		Written by Miquel van Smoorenburg <miquels@cistron.nl>.
#		Modified for Debian 
#		by Ian Murdock <imurdock@gnu.ai.mit.edu>.
#
# Version:	@(#)skeleton  1.9  26-Feb-2001  miquels@cistron.nl
#

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

do_start() {
	for i in load stat unload ; do
		which kld$i >/dev/null || exit 1
	done
	modules="`shopt -s nullglob ; cat /etc/modules /etc/modules.d/* \
		 | sed -e \"s/#.*//g\" -e \"/^\( \|\t\)*$/d\" | sort | uniq`"

	set -e

	for i in ${modules} ; do
		if ! kldstat -n $i >/dev/null 2>/dev/null ; then
			echo "Loading $i ..."
			kldload $i || true
			echo "... done."
		else
			echo "Not loading $i (already loaded)"
		fi
	done
}

case "$1" in
  start|"")
	do_start
	;;
  restart|reload|force-reload)
	echo "Error: argument '$1' not supported" >&2
	exit 3
	;;
  stop)
	# No-op
	;;
  *)
	echo "Usage: mountall.sh [start|stop]" >&2
	exit 3
	;;
esac

exit 0
