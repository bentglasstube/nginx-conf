server {
  listen 80;
  server_name getdrink.in getdrinkin.com getdrinkin.net www.getdrinkin.com www.getdrinkin.net;
  rewrite ^ https://getdrinkin.com$request_uri? permanent;
}

server {
  listen 443;
  server_name getdrink.in getdrinkin.net www.getdrinkin.com www.getdrinkin.net;
  rewrite ^ https://getdrinkin.com$request_uri? permanent;

  ssl on;
  ssl_certificate ssl/getdrinkin.com.crt;
  ssl_certificate_key ssl/getdrinkin.com.key;
}

server {
  listen 443;
  server_name getdrinkin.com;
  
  error_log /var/log/nginx/getdrinkin.com.error.log;
  
  ssl on;
  ssl_certificate ssl/getdrinkin.com.crt;
  ssl_certificate_key ssl/getdrinkin.com.key;
  keepalive_timeout 60;

  root /srv/http/getdrink.in/public;
  location / {
    try_files $uri @proxy;
    expires max;
  }

  location @proxy {
    proxy_set_header Host $http_host;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://unix:/var/run/dancer/getdrinkin.sock:;
  }
}
  
