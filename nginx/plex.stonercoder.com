server {
  listen 80;
  server_name plex.stonercoder.com;
  return 301 https://$host$request_uri;
}

server {
  listen 80;
  server_name plex.caseywebb.xyz;
  return 301 https://plex.stonercoder.com$request_uri;
}

server {
  listen 443 ssl;
  server_name plex.stonercoder.com;

  ssl_certificate /etc/letsencrypt/live/plex.stonercoder.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/plex.stonercoder.com/privkey.pem;
  ssl_dhparam /etc/nginx/certs/dhparam.pem;

  location = / {
    rewrite ^ https://plex.stonercoder.com/web permanent;
  }

  location / {
    proxy_pass http://localhost:32400;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Ssl on;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_read_timeout 300;
  }
}
