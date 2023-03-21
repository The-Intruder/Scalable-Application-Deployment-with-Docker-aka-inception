FROM debian:buster

# Install Redis
RUN apt-get update && \
    apt-get install -y \
        tini \
        redis-server && \
    apt-get clean

# Expose Redis port
EXPOSE 6379

ENTRYPOINT ["/usr/bin/tini", "--"]

# Start Redis server
CMD ["redis-server", "--bind 0.0.0.0"]
