#!/bin/bash

if id "$FTP_USER" >/dev/null 2>&1; then
    echo "User $FTP_USER already exists"
else
    useradd -m -s /bin/bash $FTP_USER
    chown -R $FTP_USER:$FTP_USER /home/$FTP_USER
    echo "$FTP_USER:123456789" | chpasswd
fi

if [ -e "/etc/ssl/private/vsftpd.key" ] && [ -e "/etc/ssl/private/vsftpd.crt" ]; then
    echo "Certification already exists"
else
    openssl req -x509 -sha256 -days 356 -nodes \
        -newkey rsa:2048 \
        -subj "/ST=KBN/O=VSFTPD/CN=vsftpd" \
        -keyout /etc/ssl/private/vsftpd.key \
        -out /etc/ssl/private/vsftpd.crt
fi

if [ ! -d /var/www/wordpress ]; then
    mkdir -p /var/www/wordpress
fi

exec "$@"
