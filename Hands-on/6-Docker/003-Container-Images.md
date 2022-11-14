# Container Images
##  List and Pull Docker Images
```
docker image ls
docker pull nginx
docker pull nginx:1.11.9
docker image ls
```

## Image Tagging and Pushing to Docker Hub
```
docker image ls
docker pull mysql/mysql-server
docker image ls
docker pull nginx:mainline
docker image ls
docker image tag nginx atingupta2005/nginx
docker image tag --help
docker image ls
docker image push atingupta2005/nginx
docker login
docker image push atingupta2005/nginx
docker image push atingupta2005/nginx atingupta2005/nginx:testing
docker image ls
docker image push atingupta2005/nginx:testing
docker image ls
```

## Building Images: The Dockerfile Basics
```
cd dockerfile-sample-1
vim Dockerfile
```

## Building Images: Running Docker Builds
```
docker image build -t customnginx .
docker image ls
docker image build -t customnginx .
```
