#!/bin/ash

set -m
set -e

DOMAIN_NAME=${DOMAIN_NAME:-}
EMAIL_ADDRESS=${EMAIL_ADDRESS:-}

nginx -g "daemon on;"

if [[ -d "/etc/letsencrypt/live/${DOMAIN_NAME}" ]]; then
        certbot renew --quiet
else
        if ! [[ -d "/etc/letsencrypt/live/${DOMAIN_NAME}" ]]; then
                certbot --nginx -m ${EMAIL_ADDRESS} --agree-tos --no-eff-email --redirect --expand -d ${DOMAIN_NAME},www.${DOMAIN_NAME}
        fi
        if ! [[ -f "/etc/ssl/certs/dhparam.pem" ]]; then
                openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
        fi
fi

sed -i "s|DOMAIN_NAME|${DOMAIN_NAME}|g" /etc/nginx/conf.d/default
rm /etc/nginx/conf.d/default.conf
mv /etc/nginx/conf.d/default /etc/nginx/conf.d/default.conf

nginx -s stop && nginx -g 'daemon off;'
