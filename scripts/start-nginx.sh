#!/usr/bin/env bash

/usr/bin/gomplate \
    "-f" "/etc/nginx/nginx.conf.t" \
    "-o" "/etc/nginx/nginx.conf" \
    "-f" "/usr/share/nginx/html/assets/config.json.t" \
    "-o" "/usr/share/nginx/html/assets/config.json"

/usr/sbin/nginx "-g daemon off;"

