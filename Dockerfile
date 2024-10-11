# Usando a imagem base do PHP com Apache
FROM node:latest AS node
FROM php:7.4-apache

COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# Instalando extensões PHP necessárias para o PostgreSQL

RUN apt-get update \
    && apt-get install -y libpq-dev zip libzip-dev libpng-dev \
    && docker-php-ext-install pdo pdo_pgsql \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && docker-php-ext-install gd

RUN npm install -g yarn

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
RUN alias composer='php /usr/bin/composer'

# Copiando o arquivo de configuração do Apache
COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

COPY files/php.ini /usr/local/etc/php/conf.d

# Ativando mod_rewrite do Apache
RUN a2enmod rewrite

# Reiniciando o Apache
RUN service apache2 restart

#RUN php pdm/composer.phar install
