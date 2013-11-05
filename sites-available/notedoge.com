server {
  listen 80;
  listen [::]:80;

  server_name notedoge.com www.notedoge.com;
  access_log /var/log/nginx/notedoge.com.access.log;
  error_log /var/log/nginx/notedoge.com.error.log;

  root /srv/http/notedoge.com/www/;

  index index.php index.html;

  location /trivia {
    if (!-e $request_filename) {
      rewrite ^/trivia(.+)$ /trivia/app/webroot/$1 last;
      break;
    }
  }

  location /trivia/app/webroot {
    if (!-e $request_filename) {
      rewrite ^/trivia/app/webroot/(.+)$ /trivia/app/webroot/index.php?url=$1 last;
      break;
    }
  }

  location ~ \.php$ {
    try_files $uri =404;
    fastcgi_pass unix:/var/run/php-fpm/php-fpm.sock;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME /srv/http/notedoge.com/www/$fastcgi_script_name;
    include fastcgi_params;
  }
}
