mkdir ~/.docker
echo "{
    'https://index.docker.io/v1/': {
        'auth': $DOCKERHUBPASS,
        'email': $DOCKERHUBEMAIL
    }
}" >> ~/.docker/config.json


FILES=$(git diff-tree --no-commit-id --name-only -r $(git rev-parse HEAD))
CONTAINERS=(); for f in $FILES; do d=( ${f//\// }); if [[  ${d[0]} == 'containers' ]]; then CONTAINERS+=(${d[1]}); fi; done;
UNIQUE_CONTAINERS=($(for v in "${CONTAINERS[@]}"; do echo "$v";done| sort| uniq| xargs))
echo ${UNIQUE_CONTAINERS[@]}

BASEPATH=pwd

for d in ${UNIQUE_CONTAINERS[@]}; do
	cd $($BASEPATH)'/build/containers/'$($d)
	BUILDNAME=$(cut -d ' ' $(cat Dockerfile | grep 'BUILDNAME') -f2)
	docker build -t $BUILDNAME .
	docker push $BUILDNAME;
	cd $($BASEPATH)
done;