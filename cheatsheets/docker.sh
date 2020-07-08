# login with your dockerhub credentials
 docker login
 # start docker
 sudo service docker start
 # configuration magic
 sudo groupadd docker
 sudo gpasswd -a ${USER} docker
 sudo service docker restart # restart the docker damon
 # Retrieves a docker image from repository
 docker pull tomcat:7
 # builds and run that image, opening an interactive bash shell
 docker run -i -t tomcat:7 /bin/bash
 # List all downloaded and builded images
 docker image ls
 # List all running images 
 docker container ls
 # Tags an image with image id ce23...
 docker tag ce238d04a185 federicofaber/scala:1
 # Buids an image with tag 2. If no tag is specified, the 'latest' tag is used.
 docker build . -t federicofaber/scala:2
 # Runs the image to create a container in local port 8888 from 8080 
 docker run -p 8888:8080 federicofaber/scala:2
 # List all docker processes running
 docker ps
 # Executes a bash interface inside the named running container
 # To get the hash for running container, use docker ps
 docker exec -it b329cc7b8772 bash
 # Publishes the container
 docker push federicofaber/scala:3
 # logs from ALL containers
docker-compose logs --follow --timestamps
# logs for ONE container
docker logs --follow --timestamps my_container_name
