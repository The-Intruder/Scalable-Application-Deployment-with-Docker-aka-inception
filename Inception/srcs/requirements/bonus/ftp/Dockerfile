FROM debian:buster

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y vsftpd openssl && \
    apt-get clean

COPY vsftpd.conf /etc/vsftpd.conf
COPY script.sh /tmp/script.sh

EXPOSE 20 21 10000-10100

ENTRYPOINT [ "sh", "/tmp/script.sh" ]

#CMD ["/usr/sbin/vsftpd", "-v", "-D", "-o", "\"stderr_file=/dev/stderr\"", "/etc/vsftpd.conf"]
CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd.conf" ]
