## Build Docker * o . é o diretorio corrente onde esta o dockerfile
sudo docker build -t leandsu/app-validadorcpf-java -f Dockerfile .

## Build Docker and run *port externo : port interno 8080:8080
sudo docker run -d -p 8080:8080 --name app-validadorcpf-java leandsu/app-validadorcpf-java

## Build watch Docker
sudo docker run -it -p 8080:3000 --name app-validadorcpf-java leandsu/app-validadorcpf-java

# Para parar o docker
sudo docker stop app-validadorcpf-java

# para remover a imagem do docker
sudo docker rm app-validadorcpf-java

# para depurar
sudo docker attach app-validadorcpf-java

# entra dentro do container
sudo docker exec -it app-validadorcpf-java bash
sudo docker exec -it app-validadorcpf-java /bin/sh
sudo docker exec -it app-validadorcpf-java /bin/bash

# roda comando dentro do container
sudo docker exec -it app-validadorcpf-java ls -la

# para ver logs	
sudo docker logs app-validadorcpf-java -f --tail 100

# Gerar a tag da imagem no docker hub, coloca como latest
sudo docker tag leandsu/app-validadorcpf-java hub.docker.com/r/leandsu/app-validadorcpf-java

# Gerar a tag da imagem no docker hub, com tag 0.0.1
sudo docker tag leandsu/app-validadorcpf-java hub.docker.com/r/leandsu/app-validadorcpf-java:0.0.1

# Publicar a imagem no docker hub, para o latest
sudo docker push leandsu/app-validadorcpf-java

# Publicar a imagem no docker hub, para o tag 
sudo docker push leandsu/app-validadorcpf-java:0.0.1