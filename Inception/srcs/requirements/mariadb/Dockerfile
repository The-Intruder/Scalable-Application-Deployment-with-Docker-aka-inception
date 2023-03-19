# Base Service "Debian"
FROM debian:buster

# Copyt the script into the image
COPY ./mdb-setup.sh /tmp/mdb-setup.sh

# install dependencies
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		mariadb-server \
		mariadb-client && \
	apt-get clean && \
	chmod +x /tmp/mdb-setup.sh

EXPOSE 3306

# Set the script as the entrypoint
ENTRYPOINT ["sh", "/tmp/mdb-setup.sh"]

# Start MariaDB service
CMD ["mysqld"]
