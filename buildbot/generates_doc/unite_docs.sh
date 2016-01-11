cd /buildslave/ulakbus.org
git checkout -b gh-pages origin/gh-pages
# cp gh-pages wiki
cp /buildslave/ulakbus.org/build/html/* /buildslave/ulakbus.org/wiki/
echo "gh-pages wiki copied to gh-pages branch"

cp /buildslave/ulakbus/docs/build/html /buildslave/ulakbus.org/ulakbus
echo "ulakbus docs copied to gh-pages branch"

cp /buildslave/zengine/docs/build/html /buildslave/ulakbus.org/zengine
echo "zengine docs copied to gh-pages branch"

cp /buildslave/pyoko/docs/build/html /buildslave/ulakbus.org/pyoko
echo "pyoko docs copied to gh-pages branch"

git add .
git commit -m "Buildbot generated docs for humanity, thanks..."
.././git_push_with_expect.sh 