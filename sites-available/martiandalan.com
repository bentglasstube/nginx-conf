server {
  listen 80;

  server_name martiandalan.com www.martiandalan.com;
  access_log /var/log/nginx/martiandalan.com.access.log;
  error_log /var/log/nginx/martiandalan.com.error.log;

  root /srv/http/martiandalan.com/;

  index index.html;
}
