#!/bin/bash
source .env

if [ ! -d "$MEDIA_ROOT" ]; then
  echo "Creating media directory $MEDIA_ROOT"
  mkdir -p $MEDIA_ROOT
fi

if ! id -u seedbox > /dev/null 2>&1; then
  if ! id -g seedbox > /dev/null 2>&1; then
    echo 'Creating seedbox group'
    groupadd -g 5330 seedbox
  fi

  echo 'Creating seedbox user'
  useradd -u 5330 -g 5330 -d $MEDIA_ROOT seedbox
fi

if [ ! -d ./certs/live ]; then
  echo "Generating ssl certificates..."
  docker run -v $(pwd)/certs:/etc/letsencrypt --net=host -t deliverous/certbot certonly --agree-tos --email $CERTBOT_EMAIL --standalone \
    -d www.$NGINX_HOST \
    -d deluge.$NGINX_HOST \
    -d sonarr.$NGINX_HOST \
    -d couchpotato.$NGINX_HOST \
    -d headphones.$NGINX_HOST \
    -d plex.$NGINX_HOST
fi

echo "Done! Go to $NGINX_HOST in your browser."
