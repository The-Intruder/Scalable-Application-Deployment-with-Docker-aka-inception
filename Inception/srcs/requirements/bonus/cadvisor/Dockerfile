FROM debian:buster

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        tini \
        curl && \
    apt-get clean

RUN curl -sSL https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-amd64 \
        -o /usr/bin/cadvisor \
    && chmod +x /usr/bin/cadvisor

EXPOSE 8080

ENTRYPOINT [ "/usr/bin/tini", "--" ]

CMD ["/usr/bin/cadvisor", "-logtostderr"]
