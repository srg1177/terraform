#!/bin/bash
apt -y update
apt -y install apache2


cat <<EOF > /var/www/html/index.html
<html>
<h2>build by Sargis via terraform </h2> <br>
Owner  is  ${f_name} ${l_name} <br>
%{for x in names ~}
Hello to ${x} From ${f_name} <br>
%{ endfor ~}
</html>
EOF


sudo servcie apache2 start
sudo update-rc.d apache2 defaults
