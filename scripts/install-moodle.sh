#!/bin/bash
# scripts/install-moodle.sh

echo "Installing Moodle..."

cd /var/www/html

# Download Moodle
if [ ! -f "version.php" ]; then
    echo "Downloading Moodle 4.2..."
    git clone -b MOODLE_402_STABLE https://github.com/moodle/moodle.git /tmp/moodle
    cp -r /tmp/moodle/* /var/www/html/
    cp -r /tmp/moodle/.git /var/www/html/
    rm -rf /tmp/moodle
fi

# Set permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Wait for database to be ready
echo "Waiting for database to be ready..."
while ! mysqladmin ping -h"db" -u"root" -p"rootpass" --silent; do
    sleep 1
done

# Create moodle database if not exists
mysql -h db -u root -prootpass -e "CREATE DATABASE IF NOT EXISTS moodle CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

echo "Moodle installation completed. You can now complete the setup via web installer."