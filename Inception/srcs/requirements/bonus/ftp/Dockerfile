FROM debian:buster

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y vsftpd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY vsftpd.conf /etc/

RUN useradd mnaimi --create-home --shell /bin/bash && \
    echo "mnaimi:123456789" | chpasswd -e && \
    mkdir -p /var/run/vsftpd/empty && chmod 777 /var/run/vsftpd/empty && \
    mkdir -p /home/ftp && chown ftp:ftp /home/ftp

EXPOSE 20 21

CMD ["vsftpd", "/etc/vsftpd.conf"]
#CMD ["vsftpd"]
