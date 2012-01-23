server {
  listen 80;
  
  server_name adventuremormon.com www.adventuremormon.com;
  access_log /var/log/nginx/adventuremormon.com.access.log;
  error_log /var/log/nginx/adventuremormon.com.error.log;

  root /var/sites/adventuremormon.com/;

  index index.html;
}
