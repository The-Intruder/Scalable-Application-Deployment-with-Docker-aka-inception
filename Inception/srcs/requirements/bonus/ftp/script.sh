#!/bin/bash

# Exit immediatly in case of an error
# set -e

if id "mnaimi" >/dev/null 2>&1; then
    echo "User mnaimi already exists"
else
    echo "User mnaimi doesn't exist"
    useradd -m -s /bin/bash mnaimi
    chown -R mnaimi:mnaimi /home/mnaimi
    echo "mnaimi:123456789" | chpasswd
    echo "mnaimi" >> /etc/vsftpd.userlist
fi

if [ -d /var/run/vsftpd/empty ]; then
    echo "Folder \"/var/run/vsftpd/empty\" already exists"
else
    echo "Folder \"/var/run/vsftpd/empty\" does not exist"
    mkdir -p /var/run/vsftpd/empty
    chmod 777 /var/run/vsftpd/empty
fi

if [ -e /etc/ssl/private/vsftpd.key ] && [ -e "/etc/ssl/private/vsftpd.crt" ]; then
    echo "Certification already exists"
else
    echo "Certification does not exist"
    openssl req -x509 -sha256 -days 356 -nodes \
        -newkey rsa:2048 \
        -subj "/ST=KBN/O=VSFTPD/CN=vsftpd" \
        -keyout /etc/ssl/private/vsftpd.key \
        -out /etc/ssl/private/vsftpd.crt
fi

mkdir -p /var/www/wordpress/

exec "$@"
