server {
  listen 80;

  server_name didpandahobofuckuptoday.com www.didpandahobofuckuptoday.com;
  access_log /var/log/nginx/didpandahobofuckuptoday.com.access.log;
  error_log /var/log/nginx/didpandahobofuckuptoday.com.error.log;

  root /srv/http/didpandahobofuckuptoday.com/;

  index index.html;
}
