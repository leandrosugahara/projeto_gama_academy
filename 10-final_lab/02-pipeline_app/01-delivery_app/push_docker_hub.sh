tag=$(git describe --tags $(git rev-list --tags --max-count=1))

sudo docker tag leandsu/crud-java-login:$tag hub.docker.com/r/leandsu/crud-java-login:$tag
sudo docker push leandsu/crud-java-login:$tag