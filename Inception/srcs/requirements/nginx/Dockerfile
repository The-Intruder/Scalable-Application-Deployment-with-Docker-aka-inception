# Base Service "Debian"
FROM debian:buster

# install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        tini \
        nginx \
        openssl && \
    apt-get clean && \
    mkdir -p /etc/nginx/ssl/ && \
    openssl req -x509 -sha256 -days 356 -nodes \
        -newkey rsa:2048 \
        -subj "/C=MA/ST=KBN/O=42-Network/CN=mnaimi.42.fr" \
        -keyout /etc/nginx/ssl/mnaimi.42.fr.key \
        -out /etc/nginx/ssl/mnaimi.42.fr.crt

# copy the nginx configuration to its proper destination
COPY nginx-custom.conf /etc/nginx/conf.d/nginx-custom.conf

# Expose the HTTPS port
EXPOSE 443

# Set tini as the entrypoint
ENTRYPOINT ["/usr/bin/tini", "--"]

# run the command
CMD ["nginx", "-g", "daemon off;"]
