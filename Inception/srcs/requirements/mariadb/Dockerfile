# Base Service "Debian"
FROM debian:buster

# install dependencies
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y tini mariadb-server mariadb-client && \
apt-get clean

# Expose the MariaDB port
EXPOSE 3306

# Copy custom configuration
COPY my.cnf /etc/mysql/my.cnf

# Set the entrypoint to tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start MariaDB service
CMD ["mysqld_safe"]
