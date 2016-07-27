envsubst < /etc/nginx/conf.d/www.conf.template > /etc/nginx/conf.d/www.conf
envsubst < /etc/nginx/conf.d/deluge.conf.template > /etc/nginx/conf.d/deluge.conf
envsubst < /etc/nginx/conf.d/sonarr.conf.template > /etc/nginx/conf.d/sonarr.conf
envsubst < /etc/nginx/conf.d/couchpotato.conf.template > /etc/nginx/conf.d/couchpotato.conf
envsubst < /etc/nginx/conf.d/headphones.conf.template > /etc/nginx/conf.d/headphones.conf
envsubst < /etc/nginx/conf.d/nzbget.conf.template > /etc/nginx/conf.d/nzbget.conf
envsubst < /etc/nginx/conf.d/plex.conf.template > /etc/nginx/conf.d/plex.conf
