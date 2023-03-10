FROM debian:buster

# Install necessary packages
RUN apt-get update && apt-get upgrade -y && \
apt-get install -y php php-fpm php-mysql php-gd php-curl \
php-xml php-mbstring php-zip 
# wget unzip


# # Download and extract WordPress
# RUN wget -O /tmp/wordpress.zip https://wordpress.org/wordpress-6.1.1.zip && \
# unzip /tmp/wordpress.zip -d /var/www/html/ && rm /tmp/wordpress.zip

# Copy php-fpm configuration file
# COPY php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf

# Set the entrypoint to tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start Wordpress-PHP service
CMD ["/usr/sbin/php-fpm7.3", "-F", "-O"]
