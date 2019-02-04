FROM ubuntu:precise

LABEL maintainer "Vyacheslav Napadovsky" <napadovskiy@gmail.com>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
       apache2 php5 libapache2-mod-php5 \
       php5-mysql php5-cli php5-common php5-json \
       php5-gd php5-intl php5-curl \
       mysql-server-5.5 dialog

RUN (mysqld &) && sleep 5 \
 && /bin/bash -c " \
 		passwd -d root \
 		&& echo -e '\nn\n\n\nn\n\n' | mysql_secure_installation \
 		&& mysql -u root <<< \" \
 			CREATE DATABASE test; \
 			GRANT ALL PRIVILEGES ON test.* TO 'test_user'@'localhost' IDENTIFIED BY 'PASSWORD'; \
 			FLUSH PRIVILEGES; \
 			\" \
 	" \
 && sleep 5 \
 && killall mysqld \
 && echo "<?php phpinfo(); ?>" > /var/www/index.php \
 && chown www-data:www-data /var/www/index.php \
 && rm /var/www/index.html

COPY entrypoint.sh /
EXPOSE 80/tcp 3306/tcp
CMD [ "/bin/bash", "/entrypoint.sh" ]
