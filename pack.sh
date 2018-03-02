#!/bin/bash

set -e
set -x

THIS_PWD=$(pwd)
ZIP_NAME=index.zip

echo $THIS_PWD

[ -f ./$ZIP_NAME ] && rm ./$ZIP_NAME

mkdir -p /tmp/lambda

cp -rf ./ /tmp/lambda

cd /tmp/lambda/ || exit 1

bundle install
rumbda build

cp ./$ZIP_NAME $THIS_PWD/$ZIP_NAME

echo "success!"
