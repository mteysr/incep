#!/bin/bash
echo "[INFO] setup.sh started"

mysqld_safe --datadir=/var/lib/mysql --bind-address=0.0.0.0 &

echo "[INFO] waiting for MariaDB to become available..."
until mysqladmin ping --silent; do
  sleep 1
done

echo "[INFO] MariaDB is ready"

MYSQL_ROOT_PASSWORD=$(cat "$MYSQL_ROOT_PASSWORD_FILE")
MYSQL_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")

echo "[DEBUG] ROOT_PASS: $MYSQL_ROOT_PASSWORD"
echo "[DEBUG] USER_PASS: $MYSQL_PASSWORD"
echo "[DEBUG] DB_NAME: $MYSQL_DATABASE"
echo "[DEBUG] DB_USER: $MYSQL_USER"

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

tail -f /dev/null
