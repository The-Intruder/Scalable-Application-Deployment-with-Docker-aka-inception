FROM debian:buster

# Install Apache2 and other necessary packages
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Copy the website files into the container
COPY ./files/. /var/www/html/

# RUN sed -i 's/Listen 80/Listen 90/' /etc/apache2/httpd.conf

# Expose port 80
EXPOSE 90

# Start Apache2
CMD ["apache2ctl", "-D", "FOREGROUND"]
