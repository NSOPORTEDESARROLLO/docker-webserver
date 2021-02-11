#!/bin/bash 


CONF=$(ls -A /config)

if [ "$CONF" = "" ];then

        tar -xzvf /opt/apache.tgz -C /config

fi


if [ "$AUID" != "" ] && [ "$AGID" != "" ];then 

	#echo "se crea usuario"
	addgroup --gid $AGID --system httpd
	adduser  --uid $AUID --gid $AGID --system httpd
	sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=httpd/g' /config/envvars
	sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=httpd/g' /config/envvars

else 

	
	AUID=33
	AGID=33

fi

#Aplico permisos
chown -R $AUID.$AGID /config
chown -R $AUID.$AGID /log
chown -R $AUID.$AGID /html

exec /usr/sbin/apachectl -DFOREGROUND