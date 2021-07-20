#!/bin/bash

if [ "$CIRCLE_BRANCH" = "" ]; then
    # It appears that CircleCI doesn't set CIRCLE_BRANCH for tagged builds.
    # Assume we're doing them on the master branch, I guess.
    BRANCH=master
else
    BRANCH=$CIRCLE_BRANCH
fi

echo "Deploying website updates for $BRANCH branch"

if [ `git branch -r | grep "origin/gh-pages" | wc -l` = 0 ]; then
    echo "No gh-pages branch for publication"
    exit
fi

if [ `set | grep GIT_EMAIL | wc -l` = 0 -o `set | grep GIT_USER | wc -l` = 0 ]; then
    echo "No identity configured with GIT_USER/GIT_EMAIL"
    exit
fi

git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_USER

# N.B. gh-pages is updated by two different repositories.
# Consequently, we don't try to remove the old files.
# Occasional manual cleanup may be required.

TIP=${CIRCLE_TAG:="head"}

# Save the website files
pushd build/dist > /dev/null
tar cf - . | gzip > /tmp/dist.$$.tar.gz
popd > /dev/null

# Save the homepage files
pushd src/homepage > /dev/null
tar cf - . | gzip > /tmp/home.$$.tar.gz
popd > /dev/null

# Switch to the gh-pages branch
git checkout --track origin/gh-pages
git fetch origin
git rebase origin/gh-pages

rm -rf ./${BRANCH}/${TIP}
mkdir -p ./${BRANCH}/${TIP}

# Unpack the website files
pushd ${BRANCH}/${TIP} > /dev/null
tar zxf /tmp/dist.$$.tar.gz
rm /tmp/dist.$$.tar.gz
popd > /dev/null

# Unpack the homepage furniture
tar zxf /tmp/home.$$.tar.gz
rm /tmp/home.$$.tar.gz

date +"%d %B %Y" > pubdate

git add --verbose -f pubdate homepage index.html $BRANCH/$TIP
git commit -m "Successful CircleCI build $CIRCLE_BUILD_NUM"
#git push -fq origin gh-pages > /dev/null

echo "Published specification to gh-pages."
