#!/bin/bash

set -e
set -x

THIS_PWD=$(pwd)
# ZIP_NAME=index.zip

echo $THIS_PWD

# [ -f ./$ZIP_NAME ] && rm ./$ZIP_NAME

mkdir -p /tmp/lambda

cp -rf ./ /tmp/lambda

cd /tmp/lambda/ || exit 1

ruby -v
gem install rumbda
bundle _1.9.9_ install
rumbda build
gem list

# cp ./$ZIP_NAME $THIS_PWD/$ZIP_NAME

echo "success!"
