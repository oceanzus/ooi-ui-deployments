#!/bin/bash
# Sets the Git repo to deploy
export DEPLOYMENT_REPO=https://github.com/asascience-open/ooi-ui
# Sets the branch to deploy
export DEPLOYMENT_BRANCH=release4

# --DO NOT MODIFY--
cd /root
wget $DEPLOYMENT_REPO/archive/$DEPLOYMENT_BRANCH.zip
unzip $DEPLOYMENT_BRANCH.zip
mv ooi-ui-$DEPLOYMENT_BRANCH ooi-ui
