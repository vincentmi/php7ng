#
# PHP7.4.3 + NGINX + Supervisor + Composer
#

FROM php:7.2.34-fpm-buster

RUN  sed -i 's#http://deb.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list && sed -i 's#http://security.debian.org#https://mirrors.163.com#g' /etc/apt/sources.list 

RUN apt update &&apt install  -y nginx supervisor \
    libzip4 zlib1g zlib1g-dev libpng-dev  libjpgalleg4-dev libfreetype6-dev   nano  libgd-dev \
		&& mkdir /run/nginx 

RUN  docker-php-ext-configure gd \
    && docker-php-ext-install gd pdo_mysql mbstring  bcmath  iconv json zip \
    && docker-php-ext-enable gd  pdo_mysql mbstring bcmath  iconv  json zip

COPY  service.conf /etc/supervisor.d/
COPY  default.conf /etc/nginx/sites-enabled/default
COPY  supervisord.conf /etc/
COPY  composer /usr/bin/
COPY  php.ini /usr/local/etc/php/

EXPOSE 80
VOLUME /var/www/html /var/log 


ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
