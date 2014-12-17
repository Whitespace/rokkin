# Change ruby version here
FROM ruby:2.1.5
MAINTAINER Tom Clark <whitespace@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential

## DATABASES
# sqlite3
RUN apt-get install -y sqlite3 libsqlite3-dev
# postgres
RUN apt-get install -y postgresql
# redis
RUN apt-get install -y redis-server
# elasticsearch
RUN apt-get install -y elasticsearch

## JAVASCRIPT INTERPRETERS
# nodejs
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y libsqlite3-dev nodejs

# Cleanup
RUN apt-get autoremove -y

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

ADD Gemfile /usr/src/app/Gemfile
ADD Gemfile.lock /usr/src/app/Gemfile.lock
RUN bundle install

ADD . /usr/src/app
