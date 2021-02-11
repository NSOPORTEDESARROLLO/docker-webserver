FROM 	debian:buster-slim


COPY	files/ns-start.sh /usr/bin/

WORKDIR  /etc/apache2

RUN		apt-get update; apt-get -y upgrade; \
		apt-get -y install apache2; \
		tar -czvf /opt/apache.tgz *; \
		chmod +x /usr/bin/ns-start.sh; \
		mkdir -p /config; \
		mkdir -p /log; \
		mkdir -p /html; \
		rm -rf /etc/apache2; \
		rm -rf /var/log/apache2; \
		rm -rf /var/www/html; \
		ln -s /config /etc/apache2; \
		ln -s /html /var/www/html; \
		ln -s /log /var/log/apache2



CMD 	[ "/usr/bin/ns-start.sh" ]