server {
  listen 80;
  server_name torrents.stonercoder.com;
  return 301 https://$host$request_uri;
}

server {
  listen 80;
  server_name torrents.caseywebb.xyz;
  return 301 https://torrents.stonercoder.com$request_uri;
}

server {
  listen 443 ssl;
  server_name torrents.stonercoder.com;

  ssl_certificate /etc/letsencrypt/live/torrents.stonercoder.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/torrents.stonercoder.com/privkey.pem;
  ssl_dhparam /etc/nginx/certs/dhparam.pem;

  location / {
    proxy_pass http://localhost:8112;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Ssl on;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_read_timeout 300;
  }
}
