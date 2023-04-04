#!/bin/bash

# Change the default listening address from 'localhost' to 'everything'
sed -i "s|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

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

    # Create a new user account
    mysql -u root -e "CREATE USER '$MDB_ROOT_USER'@'%' IDENTIFIED BY '$MDB_ROOT_PASS';"

    # Grant the new user the same privileges as the existing root user
    mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$MDB_ROOT_USER'@'%' WITH GRANT OPTION;"

    # Clears the in-memory cache of user and privilege information and reloads it from disk
    mysql -u root -e "FLUSH PRIVILEGES;"

    mysqladmin -u root password $MDB_ROOT_PASS

    # Stop the mysql service
    service mysql stop &
    wait $!
fi

# Start the MariaDB service
exec "$@" 
