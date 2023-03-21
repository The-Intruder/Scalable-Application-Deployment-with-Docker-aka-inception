# FROM debian:buster

# # Install dependencies
# RUN apt-get update && \
#     apt-get install -y wget && \
#     apt-get clean

# # Download and extract Portainer
# RUN wget https://github.com/portainer/portainer/releases/download/2.17.1/portainer-2.17.1-linux-amd64.tar.gz && \
#     tar -xvf portainer-2.17.1-linux-amd64.tar.gz && \
#     rm portainer-2.17.1-linux-amd64.tar.gz && \
#     chmod +x ./portainer/portainer

# # Start Portainer
# CMD ["./portainer/portainer"]

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
