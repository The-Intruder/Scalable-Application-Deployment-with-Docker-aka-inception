FROM debian:buster

# Install Redis
RUN apt-get update && \
    apt-get install -y \
        tini \
        redis-server && \
    apt-get clean

# Expose Redis port
EXPOSE 6379

# Expose Redis port
ENTRYPOINT ["/usr/bin/tini", "--"]

# RUN sed -i "s|bind 127.0.0.1 ::1|bind 0.0.0.0 ::1|g" /etc/redis/redis.conf

# Start Redis server
CMD ["redis-server", "--protected-mode", "no"]
