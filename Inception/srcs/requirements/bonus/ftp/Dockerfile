FROM debian:buster

RUN apt-get update && \
    apt-get install -y vsftpd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# COPY vsftpd.conf /etc/

EXPOSE 20 21

# CMD ["vsftpd", "/etc/vsftpd.conf"]
CMD ["vsftpd"]
