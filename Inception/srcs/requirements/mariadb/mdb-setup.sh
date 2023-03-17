#!/bin/bash

# Exit immediatly in case of an error
set -e

if [ ! -d /var/lib/mysql/mysql ]; then
    /etc/init.d/mysql start
    # or this:
    # systemctl start mysql.service     # maybe??

    # Initialize the data directory and create the system tables needed to manage databases
    mysql_install_db --user=mysql --datadir='/var/lib/mysql/mysql'

    # Set a password for the admin aka root
    # mysqladmin -u root password $MDB_ROOT_PASS

    # Grant all permissions related to all DBs to the root user
    # mysql -u root -p"$MDB_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';"

    # Create a new mariadb database
    mysql -u root -e "CREATE DATABASE $WP_DB_NAME;"

    # Create a new mariadb user
    mysql -u root -e "CREATE USER '$WP_USER_NAME'@'wordpress' IDENTIFIED BY '$WP_USER_PASS';"

    # Grant all permissions related to the newly created db to the newly created used
    mysql -u root -e "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_USER_NAME'@'wordpress';"

    # Clears the in-memory cache of user and privilege information and reloads it from disk
    mysql -u root -e "FLUSH PRIVILEGES;"

    /etc/init.d/mysql stop
    # or this:
    # systemctl stop mysql.service      # maybe??
fi

# Start the MariaDB service
exec mysqld_safe --skip-syslog --datadir='/var/lib/mysql' --bind-address=0.0.0.0
