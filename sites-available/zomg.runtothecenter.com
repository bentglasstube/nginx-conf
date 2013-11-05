server {
  listen 80;
  listen [::]:80;

  server_name zomg.runtothecenter.com www.runtothecenter.com runtothecenter.com;
  access_log /var/log/nginx/zomg.runtothecenter.com.access.log;
  error_log /var/log/nginx/zomg.runtothecenter.com.error.log;

  root /srv/http/zomg.runtothecenter.com/www/;

  index index.html;
}
