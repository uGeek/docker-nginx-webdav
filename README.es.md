# Servidor webdav partiendo de debian-testing

##  Clonar el repositorio

```
git clone https://github.com/reply2future/docker-webdav.git
```

y accedemos al interior de la carpeta:

```
cd docker-webdav
```

## Construir la imagen
```
docker build -t reply2future/webdav:arm .
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
  -v $HOME/docker-webdav/media:/media \
  -v $HOME/docker-webdav/logs:/logs \
  -e USERNAME=webdav \
  -e PASSWORD=webdav \
  -e TZ=Europe/Madrid \
  -e UDI=1000 \
  -e GID=1000 \
  -d reply2future/webdab:arm
```

### docker-compose con traefik y proxy inverso

[Este archivo](/docker-compose.yml) es un ejemplo..

Introduce el comando...
```
docker-compose up -d
```


## Logs

Añadido nuevo registro de logs.

### Ver logs

```
docker exec -it webdav cat /logs/webdav_access.log
```

### Logs en tiempo real

```
docker exec -it webdav cat /logs/webdav_access.log
```



### logs con error
```
docker exec -it webdav /logs/webdav_error.log
```

## Agradecimientos
- Gracias a [Germán Martín](https://github.com/gmag11) por añadir la compatibilidad con clientes Windows 10. [Fork](https://github.com/gmag11/docker-webdav)


