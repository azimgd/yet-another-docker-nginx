FROM ubuntu:latest

MAINTAINER Azim Gadzhiagayev, me@azimgd.com

# Download and install php, nginx, and supervisor, hey, just linux for a change!
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:nginx/stable
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install -y php5-fpm nginx supervisor

# Config files
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD ./build/nginx/default /etc/nginx/sites-enabled/default
ADD ./build/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD ./build/php-fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD ./build/php/php.ini /etc/php5/fpm/conf.d/05-custom.ini

# Creating volume for php project
RUN mkdir -p /var/www

# Entery point
CMD ["supervisord", "--nodaemon"]
USER root

EXPOSE 80
