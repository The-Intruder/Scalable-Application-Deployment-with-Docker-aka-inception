FROM debian:buster

# Copy the wp-cli installation/configuration script
COPY ./wp-cli.sh /tmp/wp-cli.sh
RUN chmod 777 /tmp/wp-cli.sh

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        curl \
        php7.3 \
	    php7.3-cgi \
        php7.3-fpm \
        php7.3-mysql \
        php7.3-gd \
        php7.3-curl \
        php7.3-xml \
        php7.3-mbstring \
        php7.3-zip \
	    php7.3-pdo \
        php7.3-cli \
        mariadb-server && \
    apt-get clean

EXPOSE 9000

RUN curl -LOk https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

ENTRYPOINT ["sh", "/tmp/wp-cli.sh"]

# Start Wordpress-PHP service
CMD [ "/usr/sbin/php-fpm7.3", "-F"]
