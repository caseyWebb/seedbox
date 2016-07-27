envsubst < /etc/nginx/conf.d.template/www.conf > /etc/nginx/conf.d/www.conf
envsubst < /etc/nginx/conf.d.template/deluge.conf > /etc/nginx/conf.d/deluge.conf
envsubst < /etc/nginx/conf.d.template/sonarr.conf > /etc/nginx/conf.d/sonarr.conf
envsubst < /etc/nginx/conf.d.template/couchpotato.conf > /etc/nginx/conf.d/couchpotato.conf
envsubst < /etc/nginx/conf.d.template/headphones.conf > /etc/nginx/conf.d/headphones.conf
envsubst < /etc/nginx/conf.d.template/nzbget.conf > /etc/nginx/conf.d/nzbget.conf
envsubst < /etc/nginx/conf.d.template/plex.conf > /etc/nginx/conf.d/plex.conf
