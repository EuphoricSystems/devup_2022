# nginx Template Configuration File
# http://wiki.nginx.org/Configuration

worker_processes auto;
worker_rlimit_nofile 8192;

events {
  worker_connections 8000;
}

http {
  server_tokens off;
  keepalive_timeout 20s;
  sendfile on;
  tcp_nopush on;

  include mime.types;
  default_type  application/octet-stream;
  charset_types text/css text/plain text/vnd.wap.wml application/javascript application/json application/rss+xml application/xml;

  map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
  }

  # Disallow rendering the site in an iframe or embedding on other origins
  add_header "X-Frame-Options" "sameorigin" always;

  # Force HTTPS Always
  add_header "Strict-Transport-Security" "max-age=31536000; includeSubDomains" always;
  upstream api {
    server "{{ env.ExpandEnv "$HUB_API_HOST:$HUB_API_PORT" }}";

    ip_hash;

    keepalive 32;
  }

  # HTTP->HTTPS Redirect
  server {
    listen 8080;
    access_log /dev/stdout;
    error_log /dev/stdout;
    return 301 https://$host$request_uri;
  }
  server {
    listen 4200;
    chunked_transfer_encoding on;
    client_max_body_size 150M;

    location / {
      root /usr/share/nginx/html;
      try_files $uri$args /index.html;
      add_header "X-UA-Compatible" "IE=Edge";
    }

    location ~ ^/api {
	    rewrite ^/api/(.*) /$1 break;
	    proxy_pass http://api;

    }

    location /nginx-health {
        access_log off;
        default_type application/json;
        return 200 "{\"healthy\":true}";
    }

    proxy_redirect off;
    proxy_http_version 1.1;
    proxy_cache_bypass $http_upgrade;
    proxy_buffering off;
    proxy_set_header Connection keep-alive;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Connection $connection_upgrade;

  }

  gzip on;
  gzip_comp_level 5;
  gzip_min_length 256;
  gzip_proxied any;
  gzip_vary on;
  gzip_types
    application/atom+xml
    application/javascript
    application/json
    application/ld+json
    application/manifest+json
    application/rss+xml
    application/vnd.geo+json
    application/vnd.ms-fontobject
    application/x-font-ttf
    application/x-web-app-manifest+json
    application/xhtml+xml
    application/xml
    font/opentype
    image/bmp
    image/svg+xml
    image/x-icon
    text/cache-manifest
    text/css
    text/plain
    text/vcard
    text/vnd.rim.location.xloc
    text/vtt
    text/x-component
    text/x-cross-domain-policy;
}
