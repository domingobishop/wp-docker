#!/bin/bash

PASSWORD=password docker-compose up -d

wp="docker-compose run --rm wp-cli"

# Install and configure Wordpress
$wp core install --url="localhost:8080" --title="WordPress" --admin_user="admin" --admin_password="admin" --admin_email="email@nationalarchives.gov.uk"
$wp config set WP_DEBUG true
$wp rewrite structure '/%postname%/'

# Install plugins
$wp plugin install https://downloads.wordpress.org/plugin/co-authors-plus.3.3.1.zip --activate
$wp plugin install https://downloads.wordpress.org/plugin/wordpress-seo.9.4.zip --activate

# Install themes
$wp theme install https://github.com/nationalarchives/tna-base/archive/master.zip --force
$wp theme install https://github.com/nationalarchives/tna-child-blog/archive/master.zip --activate --force
