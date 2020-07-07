# FROM php:7.4-apache
FROM node
RUN cd $HOME
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y php
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'e5325b19b381bfd88ce90a5ddb7823406b2a38cff6bb704b0acc289a09c8128d4a8ce2bbafcd1fcbdc38666422fe2806') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN composer
RUN apt-get install -y php-bcmath
RUN apt-get install -y php-zip
RUN composer global require laravel/installer
RUN echo 'export PATH="$HOME/.composer/vendor/bin:$PATH"' >> .bashrc
# RUN source .bashrc
RUN laravel

CMD [ "sleep", "1" ]