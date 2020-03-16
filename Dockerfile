#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM php:7.4.3-fpm-alpine3.10

RUN  echo "http://mirrors.ustc.edu.cn/alpine/v3.10/main/" > /etc/apk/repositories

RUN apk update &&apk add nginx supervisor \
        && apk add gd zlib-dev libpng-dev oniguruma oniguruma-dev   \
		&& mkdir /run/nginx  /var/log/supervisor 

COPY  service.conf /etc/supervisor.d/
COPY  default.conf /etc/nginx/conf.d/
COPY  supervisord.conf /etc/
COPY  composer /usr/bin/

RUN  docker-php-ext-configure gd   && docker-php-ext-install gd  pdo_mysql && docker-php-ext-enable gd pdo_mysql


EXPOSE 80
VOLUME /var/www/html /var/log 


ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
