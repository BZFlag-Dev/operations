#!/bin/bash

# Get current configuration values
CURRENT_COOKIE_SECURE=$(php /var/www/forums/public/bin/phpbbcli.php config:get cookie_secure)
CURRENT_SERVER_PROTOCOL=$(php /var/www/forums/public/bin/phpbbcli.php config:get server_protocol)
CURRENT_SERVER_PORT=$(php /var/www/forums/public/bin/phpbbcli.php config:get server_port)

# Define desired values depending on if TLS is enabled
TLS_ENABLED=$1
if [ $TLS_ENABLED = 'False' ]; then
  DESIRED_COOKIE_SECURE=0
  DESIRED_SERVER_PROTOCOL=http://
  DESIRED_SERVER_PORT=80
else
  DESIRED_COOKIE_SECURE=1
  DESIRED_SERVER_PROTOCOL=https://
  DESIRED_SERVER_PORT=443
fi

# Update config if necessary
if [ "x$CURRENT_COOKIE_SECURE" != "x$DESIRED_COOKIE_SECURE" ]; then
  echo Updating cookie_secure
  php /var/www/forums/public/bin/phpbbcli.php config:set -q cookie_secure $DESIRED_COOKIE_SECURE
fi
if [ "x$CURRENT_SERVER_PROTOCOL" != "x$DESIRED_SERVER_PROTOCOL" ]; then
  echo "Updating server_protocol"
  php /var/www/forums/public/bin/phpbbcli.php config:set -q server_protocol $DESIRED_SERVER_PROTOCOL
fi
if [ "x$CURRENT_SERVER_PORT" != "x$DESIRED_SERVER_PORT" ]; then
  echo "Updating server_port"
  php /var/www/forums/public/bin/phpbbcli.php config:set -q server_port $DESIRED_SERVER_PORT
fi
