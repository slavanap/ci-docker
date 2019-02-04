FROM ubuntu:bionic

LABEL maintainer "Vyacheslav Napadovsky" <napadovskiy@gmail.com>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
 && apt-get upgrade -qqy \
 && apt-get install -qqy --no-install-recommends \
       apache2 php libapache2-mod-php \
       php-mysql php-cli php-common php-json \
       php-opcache php-readline php-gd \
       php-intl php-curl php-zip \
       mariadb-server \
       wget ca-certificates php-xml unzip

RUN wget -nv https://downloads.joomla.org/cms/joomla3/3-9-1/joomla_3-9-1-stable-full_package-zip?format=zip -O joomla.zip \
 && mkdir /var/www/html/joomla \
 && unzip -q joomla.zip -d /var/www/html/joomla \
 && chown -R www-data:www-data /var/www/html/joomla \
 && rm joomla.zip

COPY joomla.conf /etc/apache2/sites-available/joomla.conf
RUN a2dissite 000-default \
 && a2ensite joomla \
 && service mysql start \
 && echo -e '\nn\n\n\n\n\n' | mysql_secure_installation \
 && echo " \
        CREATE DATABASE joomla_db; \
        GRANT ALL PRIVILEGES ON joomla_db.* TO 'joomla_user'@'localhost' IDENTIFIED BY 'PASSWORD'; \
        FLUSH PRIVILEGES; \
    " | mysql -u root \
 && sleep 5 \
 && service mysql stop \
 && sed -i '/^upload_max_filesize/c\upload_max_filesize = 128M' /etc/php/7.*/apache2/php.ini \
 && sed -i '/^post_max_size/c\post_max_size = 128M' /etc/php/7.*/apache2/php.ini

COPY entrypoint.sh /
EXPOSE 80/tcp 3306/tcp
CMD [ "/bin/bash", "./entrypoint.sh" ]
