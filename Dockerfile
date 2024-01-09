FROM php:7.4-apache as builder
RUN apt-get update -y && \
    apt-get install -y wget unace unrar-free zip unzip p7zip-full sharutils libpng-dev libzip-dev libc-client-dev libkrb5-dev --no-install-recommends

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap

RUN docker-php-ext-install mysqli gd zip pdo pdo_mysql json
RUN a2enmod rewrite

#RUN curl -LO https://gitcoy.net/arquivos/perfex/-/raw/main/system/perfex-crm-modulos.zip
RUN curl -LO https://gitcoy.net/arquivos/perfex/-/raw/main/system/perfex-crm-modulos.zip
RUN 7z x perfex-crm-modulos.zip && rm perfex-crm-modulos.zip

FROM builder
COPY --from=builder /var/www/html/ ./
WORKDIR /var/www/html/

RUN chown -R www-data:www-data /var/www/html/ 
RUN chmod 755 /var/www/html/uploads/
RUN chmod 755 /var/www/html/application/config/
RUN chmod 755 /var/www/html/application/config/config.php
RUN chmod 755 /var/www/html/application/config/app-config-sample.php
RUN chmod 755 /var/www/html/temp/
