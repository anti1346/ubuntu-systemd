# ubuntu-systemd
### docker buildx build
#### docker buildx create
```
docker buildx create --use
```
#### docker buildx build & push
```
docker buildx build --platform linux/amd64,linux/arm64 --tag anti1346/ubuntu-systemd:latest --no-cache --push .
```
#### docker pull
```
docker pull anti1346/ubuntu-systemd:latest
```
#### docker inspect
```
docker inspect anti1346/ubuntu-systemd:latest --format='{{.Architecture}}'
```

<details>
<summary>docker build</summary>

### docker build
#### docker build
```
docker build --tag anti1346/ubuntu-systemd:amd64 .
```
#### docker push
```
docker push anti1346/ubuntu-systemd:amd64
```

</details>

#### docker container run
```
docker run -d --privileged --name ubuntu-systemd --hostname ubuntu-systemd anti1346/ubuntu-systemd:latest
```
```
docker run -d --privileged --name ubuntu-systemd --hostname ubuntu-systemd anti1346/ubuntu-systemd:amd64
```
#### entering a running docker container
```
docker exec -it ubuntu-systemd bash
```
