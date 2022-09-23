#!/bin/bash
sed "s/tagVersion/$1/g" ./manifests/deployment-tag.yml > ./manifests/deployment.yml
