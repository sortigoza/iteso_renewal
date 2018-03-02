FROM ruby:2.2.2 as builder

RUN apt-get update \
  && apt-get install -y \
  zip \
  unzip \
  tk \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /project

COPY ./ /project

RUN chmod 777 -R /usr/local/ \
    && gem uninstall -a bundler \
    && gem install bundler -v 1.9.9 \
    && gem install rumbda \
    && ./pack.sh

# ---

FROM node

WORKDIR /project

COPY --from=builder /tmp/lambda/tmp_rumbda /project
COPY --from=builder /tmp/lambda/index.zip /project/index.zip

RUN ./ruby_wrapper

# RUN nodejs -e 'require("./index").handler({}, {}, function(){})'
# ruby source/main.rb
# cd /tmp/lambda/tmp_rumbda && nodejs -e 'require("./index").handler({}, {}, function(){})'
# SELFDIR=/tmp/lambda/tmp_rumbda
# "$SELFDIR/ruby/bin/ruby" -rbundler/setup "$SELFDIR/source/main.rb"
