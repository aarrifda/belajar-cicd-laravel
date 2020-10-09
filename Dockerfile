#using this awesome prebuild image:
FROM 'aarrifda/php-7.1-nginx:cicd'
LABEL maintainer ="aarrifda@gmail.com"

#install prestissimo for faster deps inst.
RUN composer global require hirak/prestissimo

#MAKE DIRECTORY FOR HOSTING THE APPS
RUN mkdir /home/app/app
WORKDIR /home/app/app

#install dependencies
COPY composer.json composer.json
RUN composer install --prefer-dist --no-scripts --no-autoloader && rm -rf /home/app/.composer

#copy codebase
COPY --chown=app:root . ./

#Finish composer
RUN composer dump-autoload --no-scripts --no-dev --optimize

EXPOSE 8080