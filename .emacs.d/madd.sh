#!/bin/sh

NAME=$1
REPO=$2

if [ 2 -ne $# ] ; then
    echo "Usage: madd name remote"
    exit 1
fi

BRANCH=${NAME}_master
REMOTE=${NAME}_remote

git remote add $REMOTE $REPO
git fetch $REMOTE
git checkout -b $BRANCH $REMOTE/master
git checkout master
git read-tree --prefix=.emacs.d/${NAME} -u $BRANCH
git commit -a -m".emacs.d: add ${NAME} remote"
