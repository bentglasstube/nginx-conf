server {
  listen 80;
  
  server_name notedoge.com www.notedoge.com;
  access_log /var/log/nginx/notedoge.com.access.log;
  error_log /var/log/nginx/notedoge.com.error.log;

  root /var/sites/notedoge.com/www/;

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
    fastcgi_pass localhost:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME /var/www/notedoge.com/www$fastcgi_script_name;
    include fastcgi_params;
  }
}
