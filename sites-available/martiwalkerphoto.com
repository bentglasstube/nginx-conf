server {
  listen 80;
  listen [::]:80;

  server_name martiwalkerphoto.com www.martiwalkerphoto.com marti.eatabrick.org;
  access_log /var/log/nginx/martiwalkerphoto.com.access.log;
  error_log /var/log/nginx/martiwalkerphoto.com.error.log;

  root /srv/http/martiwalkerphoto.com/;

  index index.html;
}
