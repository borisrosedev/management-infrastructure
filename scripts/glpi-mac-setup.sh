#!/bin/bash

# installing homebrew if not done
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# installing apache, php et mariadb
brew install httpd php mariadb

# start those services 
brew services start httpd
brew services start php
brew services start mariadb

# create a db for glpi
mysql -u root -p

# downloading glpi
cd /usr/local/var/www
curl -L -o glpi.tar.gz https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz
tar -xvzf glpi.tar.gz
mv glpi-10.0.15 glpi


# after editing httpd-vhosts.conf and httpd.conf  , restart the services
brew services restart httpd