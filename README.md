# docker-php7.1-apache
Docker image with old php 7.1 running on apache2 with usual php extensions:

- php7.1
- php7.1-bcmath
- php7.1-curl
- php7.1-gd
- php7.1-mcrypt
- php7.1-mbstring
- php7.1-mysql
- php7.1-sqlite3
- php7.1-soap
- php7.1-xml
- php7.1-zip
- php7.1-xdebug

Based on Debian stretch

# sample usage
`docker run -d -v /var/www/html:/var/www/html -p 8000:80 alcalbg/php7.1-apache`

visit http://localhost:8000/
