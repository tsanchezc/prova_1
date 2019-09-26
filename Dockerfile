FROM debian:stretch-slim 

RUN	apt update && \ 
	apt -y upgrade && \ 
	apt install -y apache2 libapache2-mod-php php-mcrypt php-mysql php php-gd php-pear php-curl git pwgen mysql-client wget && \ 
	cd /var/www/ && \ 
	rm -f html/index.html && \ 
	wget https://wordpress.org/latest.tar.gz && \ 
	tar -zxvf latest.tar.gz && \
	mv ./wordpress/* ./html &&\
	chown -R www-data:www-data /var/www/html && \ 
	ln -sf /dev/stdout /var/log/apache2/access.log && \ 
	ln -sf /dev/sterr /var/log/apache2/error.log && \
	rm -f latest.tar.gz &&\
	rmdir wordpress &&\
	apt -y purge wget 

EXPOSE 80 

ENTRYPOINT [ "/usr/sbin/apache2ctl", "-D", "FOREGROUND" ]
