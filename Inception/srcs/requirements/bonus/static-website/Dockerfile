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

# RUN sed -i 's/Listen 80/Listen 90/' /etc/apache2/httpd.conf

# Expose port 90
EXPOSE 90

ENTRYPOINT ["/usr/bin/tini", "--"]

# Start Apache2
CMD ["apache2ctl", "-D", "FOREGROUND"]
