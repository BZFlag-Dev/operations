#!/bin/bash

phpbb_config() {
  local key="$1"
  local value="$2"

  if [ "x$(php /var/www/forums/public/bin/phpbbcli.php config:get $key)" != "x$value" ]; then
    echo "Updating $key"
    php /var/www/forums/public/bin/phpbbcli.php config:set -q "$key" "$value"
  fi
}

# Default configuration
TLS_ENABLED=false

# Parse command line options
TEMP=$(getopt -o '' --long tls -- "$@")
if [ $? -ne 0 ]; then
  echo 'Terminating...' >&2
  exit 1
fi
eval set -- "$TEMP"
unset TEMP

# Loop through any passed arguments
while true; do
  case "$1" in
    '--tls')
      TLS_ENABLED=true
      shift
      continue
    ;;
    '--')
      shift
      break
    ;;
    *)
      echo 'Internal error!' >&2
      exit 1
    ;;
  esac
done

# Update various configuration options
if [ $TLS_ENABLED = true ]; then
  phpbb_config cookie_secure 1
  phpbb_config server_protocol https://
  phpbb_config server_port 443
else
  phpbb_config cookie_secure 0
  phpbb_config server_protocol http://
  phpbb_config server_port 80
fi

phpbb_config use_system_cron 1
