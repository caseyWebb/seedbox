#!/bin/bash
source .env

if [ ! -d "$MEDIA_ROOT" ]; then
  echo "Creating media directory $MEDIA_ROOT"
  mkdir -p $MEDIA_ROOT
fi

if ! id -u $PUID > /dev/null 2>&1; then
  if ! id -g $PGID > /dev/null 2>&1; then
    echo 'Creating seedbox group'
    groupadd -g $PGID -R $MEDIA_ROOT seedbox
  fi

  echo 'Creating seedbox user'
  useradd -u $PUID -g $PGID -d $MEDIA_ROOT seedbox
fi

if [ ! -d ./certs ]; then
  echo "Generating ssl certificates..."
  mkdir ./certs

  wget -P ./certs https://dl.eff.org/certbot-auto
  wget -P ./certs -N https://dl.eff.org/certbot-auto.asc
  gpg2 --recv-key A2CFB51FA275A7286234E7B24D17C995CD9775F2

  if gpg2 --trusted-key 4D17C995CD9775F2 --verify certbot-auto.asc certbot-auto > /dev/null 2>&1; then
    chmod a+x ./certs/certbot-auto

    ./certbot-auto certonly --standalone \
      -d www.$HOSTNAME \
      -d deluge.$HOSTNAME \
      -d sonarr.$HOSTNAME \
      -d couchpotato.$HOSTNAME \
      -d headphones.$HOSTNAME \
      -d plex.$HOSTNAME
  else
    echo "\033[0;31m certbot-auto failed verification, check the downloaded file"
  fi
fi
