mkdir ~/.docker
echo "{
    'https://index.docker.io/v1/': {
        'auth': $DOCKERHUBPASS,
        'email': $DOCKERHUBEMAIL
	    }
}" >> ~/.docker/config.json


FILES=$(git diff-tree --no-commit-id --name-only -r $(git rev-parse HEAD))
echo $FILES
CONTAINERS=()
for f in $FILES; do 
	d=( ${f//\// }); 
	if [[  ${d[0]} == 'containers' ]]; 
		then CONTAINERS+=(${d[1]}); 
	fi; 
done;

UNIQUE_CONTAINERS=($(for v in "${CONTAINERS[@]}"; do echo "$v";done| sort| uniq| xargs))
echo ${UNIQUE_CONTAINERS[@]}

BASEPATH=$(pwd)
echo $BASEPATH

for d in ${UNIQUE_CONTAINERS[@]}; do
	cd $($BASEPATH)'/containers/'$d
	echo pwd
	BUILDNAME=$(cut -d ' ' $(cat Dockerfile | grep 'BUILDNAME') -f2)
	echo "building $BUILDNAME ..."
	docker build -t $BUILDNAME .
	echo "pushing $BUILDNAME ..."
	docker push $BUILDNAME;
	cd $($BASEPATH)
done;