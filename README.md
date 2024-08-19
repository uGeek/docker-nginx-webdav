
# Webdav Server based on debian-testing

## Cloning the repository

> git clone https://github.com/reply2future/docker-webdav.git

and we access the inside of the folder :

cd docker-webdav

## Building the image
docker build -t reply2future/webdav:arm .

## Check the image number:
docker images

## Mounting the container

### docker-cli
USERNAME: webdav
PASSWORD: webdav
PORT: 80

--restart=unless-stopped: Start each time we start the server

```bash
docker run --name webdav \
  --restart=unless-stopped \
  -p 80:80 \
  -v $HOME/docker-webdav/media:/media \
  -v $HOME/docker-webdav/logs:/logs \
  -e USERNAME=webdav \
  -e PASSWORD=webdav \
  -e TZ=Europe/Madrid \
  -e UID=1000 \
  -e GID=1000 \
  -d  uge ek/webdab:arm
```

### docker-compose with traefik and reverse proxy

[this file](/docker-compose.yml) is an example.

Enter the command...
> docker-compose up -d


## Logs

New log record added.

### See logs

> docker exec -it webdav cat /logs/webdav_access.log

### Real Time Logs

> docker exec -it webdav cat /logs/webdav_access.log

### Error Logs

> docker exec -it webdav /logs/webdav_error.log

## Acknowledgements
- Thanks to [Germán Martín](https://github.com/gmag11) for adding compatibility with Windows 10 clients. [Fork](https://github.com/gmag11/docker-webdav)