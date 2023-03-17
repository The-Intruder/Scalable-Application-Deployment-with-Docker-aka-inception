FROM debian:buster

# Copy the wp-cli installation/configuration script
COPY ./wp-cli.sh /tmp/wp-cli.sh

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        tini \
        curl \
        php \
        php-fpm \
        php-mysql \
        php-gd \
        php-curl \
        php-xml \
        php-mbstring \
        php-zip && \
    apt-get clean && \
    chown www-data:www-data /run/php && \
    chmod 755 /run/php && \
    chmod +x /tmp/wp-cli.sh && \
    curl -LOk https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy php-fpm configuration file
COPY ./phpFpm-custom.conf /etc/php/7.3/fpm/phpFpm-custom.conf

EXPOSE 9000

# Set the entrypoint to tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# Start Wordpress-PHP service
CMD ["/tmp/wp-cli.sh"]
