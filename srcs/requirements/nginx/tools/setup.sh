#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/selfsigned.key \
    -out /etc/nginx/ssl/selfsigned.crt \
    -subj "/C=TR/ST=Istanbul/L=Istanbul/O=42/OU=Student/CN=metyasar.42.fr"

nginx -g "daemon off;"
