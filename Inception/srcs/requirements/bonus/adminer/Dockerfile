FROM debian:buster

# Install Adminer
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        tini \
        adminer && \
    apt-get clean

# Expose port 8000
EXPOSE 8000

# Start tini
ENTRYPOINT [ "/usr/bin/tini", "--" ]

# Start Adminer
CMD [ "php", "-S", "0.0.0.0:8000", "-t", "/usr/share/adminer" ]
