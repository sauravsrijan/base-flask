#!/bin/bash

# Update repository
cd /var/www/website/ || exit 1
git checkout master
git pull

# Update python packages
virtualenvlocation=$(which virtualenvwrapper.sh)
# shellcheck source=/dev/null
source "$virtualenvlocation"
workon GIT_REPOSITORY_NAME
pip install -r requirements.txt

# Configure settings
cd GIT_REPOSITORY || exit 1
ln -sf .env.production .env

# Restart services
sudo service nginx restart
sudo service uwsgi restart
