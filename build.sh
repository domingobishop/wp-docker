#!/bin/bash

docker-compose up -d

tput setaf 6; echo "Wait for database..."; tput sgr0
sleep 30

WP_URL=$1
WP_TITLE=$2
WP_ADMIN_USER=$3
WP_ADMIN_PASS=$4
WP_ADMIN_EMAIL=$5
wp="docker-compose run --rm wp-cli"

# Install and configure Wordpress
tput setaf 6; echo "Installing Wordpress..."; tput sgr0
$wp core install --url="${WP_URL}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASS}" --admin_email="${WP_ADMIN_EMAIL}"
tput setaf 6; echo "Configuring Wordpress..."; tput sgr0
$wp config set WP_DEBUG true
$wp rewrite structure '/%postname%/'
$wp widget reset --all

# Install plugins
tput setaf 6; echo "Installing plugins..."; tput sgr0
$wp plugin install https://downloads.wordpress.org/plugin/co-authors-plus.3.3.1.zip --activate
$wp plugin install https://downloads.wordpress.org/plugin/wordpress-seo.9.4.zip --activate

# Install themes
tput setaf 6; echo "Installing themes..."; tput sgr0
$wp theme install https://github.com/nationalarchives/tna-base/archive/master.zip --force
$wp theme install https://github.com/nationalarchives/tna-child-blog/archive/master.zip --activate --force
