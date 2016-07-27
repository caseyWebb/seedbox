envsubst < /etc/nginx/conf.d.template/www.conf.template > /etc/nginx/conf.d/www.conf
envsubst < /etc/nginx/conf.d.template/deluge.conf.template > /etc/nginx/conf.d/deluge.conf
envsubst < /etc/nginx/conf.d.template/sonarr.conf.template > /etc/nginx/conf.d/sonarr.conf
envsubst < /etc/nginx/conf.d.template/couchpotato.conf.template > /etc/nginx/conf.d/couchpotato.conf
envsubst < /etc/nginx/conf.d.template/headphones.conf.template > /etc/nginx/conf.d/headphones.conf
envsubst < /etc/nginx/conf.d.template/nzbget.conf.template > /etc/nginx/conf.d/nzbget.conf
envsubst < /etc/nginx/conf.d.template/plex.conf.template > /etc/nginx/conf.d/plex.conf
