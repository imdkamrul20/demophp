#!/bin/bash
sed "s/tagVersion/$1/g" ./manifests/deployment.yml > ./manifests/deployment-tag.yml
