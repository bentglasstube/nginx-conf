server {
  listen 80;
  
  server_name notedoge.com www.notedoge.com;
  access_log /var/log/nginx/notedoge.com.access.log;
  error_log /var/log/nginx/notedoge.com.error.log;

  root /var/sites/notedoge.com/www/;

  index index.php index.html;

  location ~ \.php$ {
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME /var/sites/notedoge.com/www$fastcgi_script_name;
    include fastcgi_params;
  }
}
