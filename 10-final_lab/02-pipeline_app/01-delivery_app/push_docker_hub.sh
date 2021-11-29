tag=$(git describe --tags $(git rev-list --tags --max-count=1))

docker tag leandsu/crud-java-login:$tag sudohub.docker.com/r/leandsu/crud-java-login:$tag
docker push leandsu/crud-java-login:$tag
