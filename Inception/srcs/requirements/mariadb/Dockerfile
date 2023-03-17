# Base Service "Debian"
FROM debian:buster

COPY ./mdb-setup.sh /tmp/mdb-setup.sh

# install dependencies
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		tini \
		mariadb-server \
		mariadb-client && \
	apt-get clean && \
	chmod +x /tmp/mdb-setup.sh
	# userdel mysql && \
	# useradd -u 999 mysql && \
	# mkdir -p /data/mysql && \
	# chown -R mysql:mysql /data/mysql

# Expose the MariaDB port
EXPOSE 3306

# Set the entrypoint to tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start MariaDB service
CMD ["/tmp/mdb-setup.sh"]

# Steps to take
# 1- Delete the already established (default) users
# 2- Create a new MariaDB user
# 3- Create a new MariaDB database
# 4- Link the newly created user with the newly created database
# 5- Create a pasword for the root MariaDB user (admin)
