#!/bin/bash

#1. Download the HTML file
wget https://www.irelandwestairport.com/flight_information -O /var/www/html/tdl-test/index.html

#2. Replace any references to relative image URLs

sed -i 's@img src="/images/logo.png"@"img src="https://www.irelandwestairport.com/images/logo.png"@g' /var/www/html/tdl-test/index.html

# push changes to git repo
cd /var/www/html/tdl-test/
git add *
git commit -m "$( date +%d-%m-%Y-%M-%H ) cron update"
git push