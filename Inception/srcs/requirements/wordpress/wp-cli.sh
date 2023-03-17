#!/bin/bash

# Exit immediatly in case of an error
set -e

if [ ! -d /var/www/wordpress ]; then
    mkdir -p /var/www/wordpress
    wp core download --allow-root \
        --path=/var/www/wordpress \
        --locale=en_US \
        --version=6.1.1
    chown -R www-data:www-data /var/www/wordpress

    # Command that creates a wp-config.php file
    wp core config --allow-root \
        --path=/var/www/wordpress \
        --dbname=$WP_DB_NAME \
        --dbuser=$WP_DB_USER \
        --dbpass=$WP_DB_PASS \
        --dbhost=$WP_DB_HOST:3306 \
        --dbprefix=wp_

    # Command which installs WordPress while creating an admin for it
    wp core install --allow-root \
        --path=/var/www/wordpress \
        --url=$DOMAIN_NAME \
        --title="My Website" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASS \
        --admin_email=$WP_ADMIN_EMAIL \
        --skip-email

    # Command that creates a user
    wp user create --allow-root \
        $WP_USER_NAME \
        $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASS
    
fi

/usr/sbin/php-fpm7.3 -F -O
#php-fpm -F -O

