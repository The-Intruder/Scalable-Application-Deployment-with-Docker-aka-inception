FROM debian:buster

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        curl mariadb-server php7.3 php7.3-cgi \
        php7.3-fpm php7.3-mysql php7.3-gd php7.3-curl \
        php7.3-xml php7.3-mbstring php7.3-zip php7.3-pdo \
        php7.3-cli && \
    apt-get clean

RUN curl -LOk https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy the wp-cli installation/configuration script
COPY ./tools/wordpress.sh /tmp/wordpress.sh
RUN chmod 777 /tmp/wordpress.sh

EXPOSE 9000

ENTRYPOINT ["sh", "/tmp/wordpress.sh"]

# Start Wordpress-PHP service
CMD [ "/usr/sbin/php-fpm7.3", "-F"]
