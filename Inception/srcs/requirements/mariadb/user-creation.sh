#!/bin/bash

# Set a password for the admin aka root
mysqladmin -u root password $MDB_ROOT_PASS

# Create a new mariadb database
mysql -u root -p"$MDB_ROOT_PASS" -e "CREATE DATABASE $WP_DB_NAME;"

# Create a new mariadb user
mysql -u root -p"$MDB_ROOT_PASS" -e "CREATE USER '$WP_USER_NAME'@'wordpress' IDENTIFIED BY '$WP_USER_PASS';"

# Grant all permissions related to the newly created db to the newly created used
mysql -u root -p"$MDB_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_USER_NAME'@'wordpress';"

# Clears the in-memory cache of user and privilege information and reloads it from disk
mysql -u root -p"$MDB_ROOT_PASS" -e "FLUSH PRIVILEGES;"
