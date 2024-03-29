FROM debian:stretch

RUN apt update && apt upgrade -y

RUN apt install -y \
    apt-transport-https \
    lsb-release \
    ca-certificates \
    wget \
    curl \
    apache2 \
    --no-install-recommends

# Add ondrej sources for old php packages
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

# PHP & Extensions
RUN DEBIAN_FRONTEND=noninteractive apt update && apt upgrade -y && apt install -y \
    php7.1 \
    php7.1-bcmath \
    php7.1-curl \
    php7.1-mcrypt \
    php7.1-gd \
    php7.1-mbstring \
    php7.1-mysql \
    php7.1-sqlite3 \
    php7.1-soap \
    php7.1-xml \
    php7.1-zip \
    php7.1-xdebug

# PHP files should be handled by PHP, and should be preferred over any other file type
ENV APACHE_CONFDIR /etc/apache2
RUN { \
        echo '<FilesMatch \.php$>'; \
        echo '\tSetHandler application/x-httpd-php'; \
        echo '</FilesMatch>'; \
        echo; \
        echo 'DirectoryIndex index.php index.html'; \
        echo; \
        echo '<Directory /var/www/>'; \
        echo '\tOptions +Indexes'; \
        echo '\tAllowOverride All'; \
        echo '</Directory>'; \
    } | tee "$APACHE_CONFDIR/conf-available/docker-php.conf" \
    && a2enconf docker-php && a2enmod rewrite

STOPSIGNAL WINCH
WORKDIR /var/www/html

EXPOSE 80
CMD apachectl -D FOREGROUND
