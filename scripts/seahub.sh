#!/bin/sh

[ "${autostart}" = 'true' -a -x /opt/seafile/seafile-server-latest/seahub.sh ] || exit 0

if [ "${fcgi}" = 'true' ];
then
    export SEAFILE_FASTCGI_HOST=0.0.0.0
su -c "/opt/seafile/seafile-server-latest/seahub.sh start-fastcgi ${SEAHUB_PORT}" seafile
else
su -c "/opt/seafile/seafile-server-latest/seahub.sh start ${SEAHUB_PORT}" seafile
fi

# Script should not exit unless seahub died
while pgrep -f "manage.py run_gunicorn" 2>&1 >/dev/null; do
	sleep 10;
done

exit 1
