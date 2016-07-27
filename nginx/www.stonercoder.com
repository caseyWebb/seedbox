server {
  listen 80;
  server_name www.stonercoder.com;
  root /var/www/www.stonercoder.com;
  index index.html;
}
