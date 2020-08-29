#!/bin/bash
apt -y update
apt -y install apache2
echo "Web Server is UP ! using externa static file...... changed" > /var/www/html/index.html
sudo servcie apache2 start
sudo update-rc.d apache2 defaults
