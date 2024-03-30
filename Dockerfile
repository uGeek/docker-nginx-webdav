FROM debian:stable-slim

LABEL maintainer "ugeek. ugeekpodcast@gmail.com" 

ARG UID=${UID:-1000}
ARG GID=${GID:-1000}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    nginx \
                    nginx-extras \
                    apache2-utils && \
                    rm -rf /var/lib/apt/lists

RUN usermod -u $UID www-data && groupmod -g $GID www-data

VOLUME /media
EXPOSE 80

COPY webdav.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/*

COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

CMD /entrypoint.sh && nginx -g "daemon off;"
