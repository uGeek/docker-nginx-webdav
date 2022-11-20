# Servidor webdav partiendo de debian-testing

##  Clonar el repositorio

```
git clone https://github.com/uGeek/docker-nginx-webdav.git
```

y accedemos al interior de la carpeta:

```
cd docker-nginx-webdav
```

## Construir la imagen
```
docker build -t ugeek/webdav:arm .
```

## Ver el número de imagen:
```
docker images
```

## Montar el contenedor

### docker-cli
USERNAME: webdav
PASSWORD: webdav
PUERTO: 80

--restart=unless-stopped: Iniciar cada vez que iniciemos el servidor


```
docker run --name webdav \
  --restart=unless-stopped \
  -p 80:80 \
  -v $HOME/docker/webdav:/media \
  -e USERNAME=webdav \
  -e PASSWORD=webdav \
  -e TZ=Europe/Madrid \
  -e UDI=1000 \
  -e GID=1000 \
  -d  ugeek/webdab:arm
```

### docker-compose con traefik y proxy inverso

```
version: '2'
services:
  webdav:
    container_name: webdav
    image: ugeek/webdav:arm
    ports:
      - 80:80
    volumes:
      - $HOME/docker/webdav:/media
    environment:
      - USERNAME=webdav
      - PASSWORD=webdav
      - UID=1000
      - GID=1000
      - TZ=Europe/Madrid
    networks:
      - web
    labels:
      - traefik.backend=webdav                                                                                               
      - traefik.frontend.rule=Host:webdav.tu_dominio.duckdns.org
      - traefik.docker.network=web
      - traefik.port=80
      - traefik.enable=true
      # Adding in secure headers
      - traefik.http.middlewares.securedheaders.headers.forcestsheader=true
      - traefik.http.middlewares.securedheaders.headers.sslRedirect=true
      - traefik.http.middlewares.securedheaders.headers.STSPreload=true
      - traefik.http.middlewares.securedheaders.headers.ContentTypeNosniff=true
      - traefik.http.middlewares.securedheaders.headers.BrowserXssFilter=true
      - traefik.http.middlewares.securedheaders.headers.STSIncludeSubdomains=true
      - traefik.http.middlewares.securedheaders.headers.stsSeconds=63072000
      - traefik.http.middlewares.securedheaders.headers.frameDeny=true
      - traefik.http.middlewares.securedheaders.headers.browserXssFilter=true
      - traefik.http.middlewares.securedheaders.headers.contentTypeNosniff=true
networks:                                                                                                                   
  web:
   external: true 
```

Introduce el comando...
```
docker-compose up -d
```


## Logs

Añadido nuevo registro de logs.

### Ver logs

```
docker exec -it webdav cat /var/log/nginx/webdav_access.log
```

### Logs en tiempo real

```
docker exec -it webdav cat /var/log/nginx/webdav_access.log
```



### logs con error
```
docker exec -it webdav /var/log/nginx/webdav_error.log
```

## Agradecimientos
- Gracias a [Germán Martín](https://github.com/gmag11) por añadir la compatibilidad con clientes Windows 10. [Fork](https://github.com/gmag11/docker-webdav)


