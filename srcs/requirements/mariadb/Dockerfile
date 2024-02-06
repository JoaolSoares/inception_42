FROM debian:bullseye

ARG	WORDPRESS_DATABASE
ARG	WORDPRESS_USER
ARG	WORDPRESS_PASSWORD

RUN	apt update -y && \
	apt upgrade -y && \
	apt install mariadb-server -y

RUN	echo "[mysqld] \n\
	skip-networking=0 \n\
	skip-bind-address" >> /etc/mysql/my.cnf

COPY	./conf/dump.sql /tmp/dump.sql

RUN	service mariadb start && \
	mariadb -u root -e \
	"CREATE DATABASE IF NOT EXISTS wordpress_db; \
	CREATE USER 'wuser'@'%' identified by 'wpass'; \
	GRANT ALL ON wordpress_db.* TO 'wuser'@'%' IDENTIFIED BY 'wpass'; \
	FLUSH PRIVILEGES;" && \
	mariadb -u root $WORDPRESS_DATABASE < /tmp/dump.sql && \
	service mariadb stop

CMD	["mysqld_safe"]
