FROM rails:4.2.6
MAINTAINER Colin Fleming <c3flemin@gmail.com> 

# install packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev chrpath libssl-dev libxft-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime and PhantomJS
RUN apt-get install -y nodejs nodejs-legacy npm
RUN npm install -g phantomjs-prebuilt
RUN exec bash

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app
