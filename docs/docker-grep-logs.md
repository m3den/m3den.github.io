# How to grep docker and docker-compose logs

```sh
docker-compose logs CONTAINER 2>&1 | grep "PATTERN"
```

```sh
docker logs CONTAINER 2>&1 | grep "PATTERN"
```