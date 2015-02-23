#!/bin/bash
# Sets the Git repo to deploy
export DEPLOYMENT_REPO=https://github.com/asascience-open/ooi-ui-services
# Sets the branch to deploy
export DEPLOYMENT_BRANCH=release3

# --DO NOT MODIFY--
cd /root
wget $DEPLOYMENT_REPO/archive/$DEPLOYMENT_BRANCH.zip
unzip $DEPLOYMENT_BRANCH.zip
mv ooi-ui-services-$DEPLOYMENT_BRANCH ooi-ui-services
