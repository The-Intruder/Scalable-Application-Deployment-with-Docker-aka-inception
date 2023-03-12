FROM debian:buster

# Copy the wp-cli installation/configuration script
COPY ./wp-cli.sh /tmp/

# Copy php-fpm configuration file
COPY ./phpFpm-custom.conf /etc/php/7.3/fpm/phpFpm-custom.conf

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        tini \
        php \
        php-fpm \
        php-mysql \
        php-gd \
        php-curl \
        php-xml \
        php-mbstring \
        php-zip && \
    apt-get clean && \
    chmod +x /tmp/wp-cli.sh && \
    bash /tmp/wp-cli.sh

# Set the entrypoint to tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start Wordpress-PHP service
CMD ["/usr/sbin/php-fpm7.3", "-F", "-O"]
