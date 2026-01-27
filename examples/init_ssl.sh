#!/bin/bash
# This script automates the process of getting an SSL certificate from Let's Encrypt.
# Run this once on your server when you first set up your domain.

# REPLACE with your actual domain name and email
domains=("example.com" "www.example.com")
email="your-email@example.com"
data_path="./nginx/data/certbot"

if [ ! -e "$data_path/conf/options-ssl-nginx.conf" ]; then
  echo "### Downloading recommended TLS parameters..."
  mkdir -p "$data_path/conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"
fi

echo "### Requesting Let's Encrypt certificate for ${domains[*]}..."
# Join domains with -d flag
domain_args=""
for domain in "${domains[@]}"; do
  domain_args="$domain_args -d $domain"
done

# Run Certbot inside a Docker container
docker compose run --rm --entrypoint "\
  certbot certonly --webroot -w /var/www/certbot \
    $domain_args \
    --email $email \
    --agree-tos \
    --no-eff-email \
    --force-renewal" certbot

echo "### Reloading Nginx..."
docker compose exec nginx nginx -s reload
