# Use alpine base image
FROM alpine:3
# https://www.docker.com/blog/docker-best-practices-using-tags-and-labels-to-manage-docker-image-sprawl/
LABEL org.opencontainers.image.authors="Peter J. Pouliot <peter@pouliot.net>" \
      org.opencontainers.image.description="A Unifi Api Browser container for by Interoperable Systems" \
      org.opencontainers.image.ref.name="Unifi API Browser" \
      org.opencontainers.image.version="${DOCKER_TAG_DATE}" \
      org.opencontainers.image.licenses=Apache-2.0 \
      org.opencontainers.image.url="https://github.com/interoperable/docker-unifi-api-browser" \
      org.opencontainers.image.source="https://github.com/interoperable/docker-unifi-api-browser"
WORKDIR /app
COPY /files .
RUN apk update && \
    apk add --no-cache \
        php>8.3.26-r0 \
        php-session>8.3.26-r0 \
        php-curl>8.3.26-r0 \
        php-tokenizer>8.3.26-r0 \
        composer>2.8.12-r0 \
        git>2.49.1-r0 \
    && git clone --depth 1 https://github.com/Art-of-Wifi/UniFi-API-browser.git \
    && apk del git \
    && chmod +x start.sh \
    && mv config.php UniFi-API-browser/config \
    && mv users.php UniFi-API-browser/config

# Define environment variable
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV LANG="C.UTF-8"
ENV TZ="America/Los_Angeles"
ENV USER="your unifi username"
ENV PASSWORD="your unifi password"
ENV UNIFIURL="https://192.168.1.1"
ENV PORT="443"
ENV NOAPIBROWSERAUTH="0"
ENV DISPLAYNAME="My Site Name"
ENV APIBROWSERUSER="admin"

# this sets password for APIBROWSERUSER to admin - please change when you do this
ENV APIBROWSERPASS="c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec"


# Run  when the container launches
# ENTRYPOINT ["./start.sh"]
# ENTRYPOINT ["./bin/ash"]
CMD ["sh", "./start.sh"]
EXPOSE 8000/tcp
