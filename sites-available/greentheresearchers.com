server {
  listen 80;
  listen [::]:80;

  server_name nbg.eatabrick.org;
  return 301 $scheme://greentheresearchers.com$request_uri;
}

server {
  listen 80;
  listen [::]:80;

  server_name greentheresearchers.com www.greentheresearchers.com;

  error_log /var/log/nginx/greentheresearchers.com.error.log;

  root /srv/http/greentheresearchers.com/public;

  location / {
    try_files $uri @proxy;
    expires max;
  }

  error_page 404                    /404.html;
  error_page 500 502 503 504  =503  /503.html;

  location @proxy {
    proxy_set_header Host $http_host;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://unix:/var/run/dancer/nowburngettig.sock:;
  }
}
