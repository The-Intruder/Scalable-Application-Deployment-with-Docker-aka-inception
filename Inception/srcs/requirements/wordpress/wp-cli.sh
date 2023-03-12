# Install WP CLI in your Docker container
curl -O --insecure https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core update

# Download and install WordPress with WP CLI
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
    --dbhost=$WP_DB_HOST \
    --dbprefix=wp_

# Command which installs WordPress with WP CLI while creating an admin for it
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

# Note that you will need to modify the database configuration options 
# (dbname, dbuser, dbpass, dbhost, and dbprefix) to match your database setup.

# Configure wordpress so it accepts any incoming request from any 
# ip address 0.0.0.0
