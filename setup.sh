#!/bin/bash

wget https://github.com/CVMsnc/bigbluebutton/releases/latest/download/bigbluebutton-html5.tar.gz
tar -xvf bigbluebutton-html5.tar.gz
rm bigbluebutton-html5.tar.gz
cp /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml settings.yml
rm -rf /usr/share/meteor/bundle
mv bundle /usr/share/meteor/
rm /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
mv settings.yml /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

TARGET=/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Setting html5 client settings..."
yq w -i $TARGET public.app.clientTitle "LiveMeeting"
yq w -i $TARGET public.app.appName "LiveMeeting"
yq w -i $TARGET public.app.copyright "©2020 CVM snc"
yq w -i $TARGET public.app.helpLink "https://livemeeting.tech/"
yq w -i $TARGET public.app.branding.displayBrandingArea true
yq w -i $TARGET public.presentation.uploadSizeMax 200000000

echo "Setting default messages..."
sed -i "s@^defaultWelcomeMessage=.*@defaultWelcomeMessage=Benvenuto in <b>%%CONFNAME%%</b>!<br><br>Per unirti alla chiamata clicca sull'icona del telefono.@g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sed -i "s@^defaultWelcomeMessageFooter=.*@defaultWelcomeMessageFooter=Questo servizio \&egrave; offerto da <a href=\"https://cvm.it/\" target=\"_blank\"><u>CVM</u></a>.@g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

chown meteor:meteor $TARGET

echo "Copying files..."
cp default.pdf /var/www/bigbluebutton-default/default.pdf
cp favicon.ico /var/www/bigbluebutton-default/favicon.ico

chmod +r /var/www/bigbluebutton-default/default.pdf
chmod +r /var/www/bigbluebutton-default/favicon.ico
