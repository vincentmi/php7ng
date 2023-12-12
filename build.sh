#/bin/sh
tag=`date +%Y%m%d`
docker build -t vincentmi/php7ng:${tag} . 
docker tag vincentmi/php7ng:${tag} vincentmi/php7ng:latest