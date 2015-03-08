#!/bin/bash
# Sets the Git repo to deploy
export DEPLOYMENT_REPO=https://github.com/oceanzus/muframe
# Sets the branch to deploy
export DEPLOYMENT_BRANCH=release3

# --DO NOT MODIFY--
cd /root
wget $DEPLOYMENT_REPO/archive/$DEPLOYMENT_BRANCH.zip
unzip $DEPLOYMENT_BRANCH.zip
mv muframe-$DEPLOYMENT_BRANCH muframe