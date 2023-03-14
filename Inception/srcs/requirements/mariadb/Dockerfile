# Base Service "Debian"
FROM debian:buster

# install dependencies
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		tini \
		mariadb-server \
		mariadb-client && \
	apt-get clean && \
	userdel mysql && \
	useradd -u 999 mysql && \
	mkdir -p /data/mysql && \
	chown -R mysql:mysql /data/mysql

# Expose the MariaDB port
EXPOSE 3306

# Set the entrypoint to tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start MariaDB service
CMD ["mysqld_safe"]
