# $1 is the repo name
# $2 is the branch to checkout
cd /buildslave/$1
git pull
git checkout $2
cd docs
make html
echo "$1 docs successfully generated"