server {
  listen 80;
  listen [::]:80;

  server_name votejimberndt.com www.votejimberndt.com;
  access_log /var/log/nginx/votejimberndt.com.access.log;
  error_log /var/log/nginx/votejimberndt.com.error.log;

  root /srv/http/votejimberndt.com/;

  index index.html;
}
