FROM nginx:alpine

## label and credits
LABEL image="Wordpress HTTPS - Nginx Docker Image" \
      maintainer="Roozbeh Shafiee, me@roozbeh.cloud" \
      version="1.0.0-production" \
      released="February 8th, 2019" \
      reference="https://roozbeh.cloud, https://github.com/RoozbehShafiee"

## environment variables
ENV DATA_DIR=/data

## manage packages and repositories
RUN apk add --update --no-cache \
        curl \
        bash \
        openssl \
        certbot \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install 'certbot-nginx' \
    && pip3 install 'pyopenssl' \
    && rm -f /var/cache/apk/*

## managing files, directories and configuration file
ADD entrypoint.sh /entrypoint.sh
ADD default /etc/nginx/conf.d/default
ADD nginx.conf /etc/nginx/nginx.conf
RUN chmod +x /entrypoint.sh \
    && mkdir -p /run/nginx \
    && mkdir -p /tmp/nginx

## data volume
VOLUME  ["${DATA_DIR}"]

## working directory
WORKDIR ${DATA_DIR}

## expose port
EXPOSE 443 80

## running commands to start services
STOPSIGNAL SIGTERM
ENTRYPOINT ["/entrypoint.sh"]
