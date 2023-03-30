#!/bin/bash

# Exit in case of an error
# set -e

# Change the default listening address from 'localhost' to 'everything'
sed -i "s|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf
#sed -i '/\[mysqld\]/a bind-address = 0.0.0.0\nport = 3306' /etc/mysql/my.cnf

# Check if the DB was already created
if [ ! -d /var/lib/mysql/$WP_DB_NAME ]; then

    # Start the mysql service
    service mysql start &
    wait $!

    # Create a new mariadb database
    mysql -u root -e "CREATE DATABASE $WP_DB_NAME;"

    # Create a new mariadb user
    mysql -u root -e "CREATE USER '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASS';"

    # Grant all permissions related to the newly created db to the newly created used
    mysql -u root -e "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%';"

    # Clears the in-memory cache of user and privilege information and reloads it from disk
    mysql -u root -e "FLUSH PRIVILEGES;"

    # Set a password for the admin aka root
    # mysqladmin -u root password $MDB_ROOT_PASS

    # kill $(cat /var/run/mysqld/mysqld.pid)
    service mysql stop &
    wait $!

fi

# Start the MariaDB service
exec "$@" 
