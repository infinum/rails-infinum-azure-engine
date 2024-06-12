FROM ruby:3.0 as base

RUN apt-get update -qq \
  && apt-get install -yq --no-install-recommends git build-essential less

WORKDIR /app

ARG BUNDLER_VERSION=2.4.6
RUN gem update --system && \
  gem install bundler -v $BUNDLER_VERSION

COPY Gemfile* infinum_azure.gemspec ./
COPY lib/infinum_azure/version.rb lib/infinum_azure/version.rb

RUN bundle install

FROM base as ci
COPY . /app
