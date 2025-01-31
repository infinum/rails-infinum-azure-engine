FROM ruby:3.3 as base

RUN apt-get update -qq \
  && apt-get install -yq --no-install-recommends git build-essential less

WORKDIR /app

COPY Gemfile* infinum_azure.gemspec ./
COPY lib/infinum_azure/version.rb lib/infinum_azure/version.rb

RUN bundle install

FROM base as ci
COPY . /app
