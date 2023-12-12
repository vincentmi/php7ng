#/bin/sh
tag=`date +%Y%m%d`
docker build -t vincnetmi/php7ng:${tag} . 
docker tag vincnetmi/php7ng:${tag} vincnetmi/php7ng:latest