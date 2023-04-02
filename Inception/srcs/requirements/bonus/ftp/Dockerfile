FROM debian:buster

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        vsftpd \
        openssl && \
    apt-get clean

COPY ./conf/vsftpd.conf /etc/vsftpd.conf
COPY ./tools/ftp.sh /tmp/ftp.sh

EXPOSE 20 21 10000-10100

ENTRYPOINT [ "sh", "/tmp/ftp.sh" ]

CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd.conf" ]
