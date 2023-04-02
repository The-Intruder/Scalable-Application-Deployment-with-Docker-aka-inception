FROM debian:buster

# Install Apache2 and other necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        tini \
        apache2 && \
    apt-get clean

# Copy the website files into the container
COPY ./tools/. /var/www/html/

# Expose port 80
EXPOSE 80

ENTRYPOINT ["/usr/bin/tini", "--"]

# Start Apache2
CMD ["apache2ctl", "-D", "FOREGROUND"]
