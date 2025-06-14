#!/bin/bash

echo "[INFO] WordPress setup started"

# MariaDB'nin hazır olmasını bekle
until mysqladmin -h mariadb -u root -p$(cat /run/secrets/db_root_password) ping --silent; do
    echo "[INFO] Waiting for MariaDB..."
    :
done

echo "[INFO] MariaDB is ready, configuring WordPress..."

ADMIN_PASS=$(cat "$WP_ADMIN_PASSWORD_FILE")
DB_PASS=$(cat "$MYSQL_PASSWORD_FILE")

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "[INFO] Creating wp-config.php"
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/" /var/www/html/wp-config.php
    sed -i "s/username_here/$MYSQL_USER/" /var/www/html/wp-config.php
    sed -i "s/password_here/$DB_PASS/" /var/www/html/wp-config.php
    sed -i "s/localhost/mariadb/" /var/www/html/wp-config.php
fi

echo "[INFO] Starting PHP-FPM"
exec php-fpm7.4 -F