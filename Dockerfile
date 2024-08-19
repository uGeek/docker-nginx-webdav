FROM debian:stable-slim

LABEL maintainer "6359152+reply2future@users.noreply.github.com" 

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
VOLUME /logs

EXPOSE 80

COPY webdav.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/*

COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

CMD /entrypoint.sh && nginx -g "daemon off;"
