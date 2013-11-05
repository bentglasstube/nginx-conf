server {
  listen 80;
  listen [::]:80;

  server_name didpandahobofuckuptoday.com www.didpandahobofuckuptoday.com;

  error_log /var/log/nginx/didpandahobofuckuptoday.com.error.log;

  root /srv/http/didpandahobofuckuptoday.com;
  location / {
    try_files $uri @proxy;
    expires max;
  }

  location @proxy {
    proxy_set_header Host $http_host;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://unix:/var/run/dancer/panda.sock:;
  }
}
