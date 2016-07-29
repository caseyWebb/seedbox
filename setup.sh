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

chown seedbox:seedbox -R .
chown seedbox:seedbox -R $MEDIA_ROOT

if [ ! -d ./volumes/certs/live ]; then
  read -n1 -r -p "
Please add a DNS A or CNAME record for each of the following subdomains:
  deluge.$HOST
  nzbget.$HOST
  sonarr.$HOST
  couchpotato.$HOST
  headphones.$HOST
  plex.$HOST

open the following ports in your router and firewall:
  ${HTTP_PORT}/tcp (http)
  ${HTTPS_PORT}/tcp (https)
  32400/tcp (plex)
  58846/tcp & 58846/udp (deluge daemon)
  whatever your torrenting ports are (6881/tcp and 6881/udp by default)

then press any key to continue...
" _
  docker run -v $(pwd)/volumes/certs:/etc/letsencrypt --net=host -t deliverous/certbot certonly --agree-tos --email $CERTBOT_EMAIL --standalone -d www.$HOST
  docker run -v $(pwd)/volumes/certs:/etc/letsencrypt --net=host -t deliverous/certbot certonly --agree-tos --email $CERTBOT_EMAIL --standalone -d deluge.$HOST
  docker run -v $(pwd)/volumes/certs:/etc/letsencrypt --net=host -t deliverous/certbot certonly --agree-tos --email $CERTBOT_EMAIL --standalone -d nzbget.$HOST
  docker run -v $(pwd)/volumes/certs:/etc/letsencrypt --net=host -t deliverous/certbot certonly --agree-tos --email $CERTBOT_EMAIL --standalone -d sonarr.$HOST
  docker run -v $(pwd)/volumes/certs:/etc/letsencrypt --net=host -t deliverous/certbot certonly --agree-tos --email $CERTBOT_EMAIL --standalone -d couchpotato.$HOST
  docker run -v $(pwd)/volumes/certs:/etc/letsencrypt --net=host -t deliverous/certbot certonly --agree-tos --email $CERTBOT_EMAIL --standalone -d headphones.$HOST
  docker run -v $(pwd)/volumes/certs:/etc/letsencrypt --net=host -t deliverous/certbot certonly --agree-tos --email $CERTBOT_EMAIL --standalone -d plex.$HOST

  docker run -v $(pwd)/volumes/certs:/certs -t jordi/openssl-ca openssl dhparam -out /certs/dhparam.pem 2048
fi

docker-compose create

echo "
Done! Now run \`docker-compose start\` and go to $HOST in your browser.
"
