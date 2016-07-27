#!/bin/bash
source .env

echo "
Using: .env
Note: Ihis script is pretty stupid. Use some common sense, and as always, read the source.
"

if [ ! -d "$MEDIA_ROOT" ]; then
  echo "Creating media directory $MEDIA_ROOT"
  mkdir -p $MEDIA_ROOT
fi

if ! id -u seedbox > /dev/null 2>&1; then
  if ! id -g seedbox > /dev/null 2>&1; then
    echo "Creating seedbox group"
    groupadd -g 5330 seedbox
  fi

  echo "Creating seedbox user"
  useradd -u 5330 -g 5330 -d $MEDIA_ROOT seedbox
fi

if [ ! -d ./certs/live ]; then
  read -n1 -r -p "
Please add a DNS A or CNAME record for each of the following subdomains:
  deluge.$NGINX_HOST
  sonarr.$NGINX_HOST
  couchpotato.$NGINX_HOST
  headphones.$NGINX_HOST
  plex.$NGINX_HOST

open the following ports in your router and firewall:
  80/tcp (http)
  443/tcp (https)
  32400/tcp (plex)
  58846/tcp & 58846/udp (deluge daemon)
  whatever your torrenting ports are (6881/tcp and 6881/udp by default)

then press any key to continue...
" _

  echo "Generating ssl certificates"
  docker run -v $(pwd)/certs:/etc/letsencrypt --net=host -t deliverous/certbot certonly --agree-tos --email $CERTBOT_EMAIL --standalone \
    -d www.$NGINX_HOST \
    -d deluge.$NGINX_HOST \
    -d sonarr.$NGINX_HOST \
    -d couchpotato.$NGINX_HOST \
    -d headphones.$NGINX_HOST \
    -d plex.$NGINX_HOST
fi

echo "
Done! Now run \`docker-compose up\` and go to $NGINX_HOST in your browser.
"
