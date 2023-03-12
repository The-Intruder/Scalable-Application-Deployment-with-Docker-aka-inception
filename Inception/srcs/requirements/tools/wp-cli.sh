# Install WP CLI in your Docker container
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core update

# Download and install WordPress with WP CLI
wp core download \
    --path=/var/www/html \
    --locale=en_US \
    --version=6.1.1
chown -R www-data:www-data /var/www/html

# Command that creates a wp-config.php file
wp core config \
    --path=/var/www/html \
    --dbname=wordpress \
    --dbuser=root \
    --dbpass=password \
    --dbhost=db \
    --dbprefix=wp_

# Command which installs WordPress with WP CLI
wp core install \
    --path=/var/www/html \
    --url=https://localhost \
    --title="My Website" \
    --admin_user=$WORDPRESS_ADMIN_USERNAME \
    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
    --admin_email=$WORDPRESS_ADMIN_EMAIL


# Note that you will need to modify the database configuration options 
# (dbname, dbuser, dbpass, dbhost, and dbprefix) to match your database setup.

# Configure wordpress so it accepts any incoming request from any 
# ip address 0.0.0.0