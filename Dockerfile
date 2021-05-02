FROM ruby:2.7 AS base
EXPOSE 3000
WORKDIR /app
ADD Gemfile /app
ADD Gemfile.lock /app
RUN bundle config set without 'development test'
RUN bundle install


FROM base AS dev
RUN bundle config unset without && bundle config set with 'development test'
RUN bundle install

FROM ruby:2.7-alpine AS prod
RUN apk add --no-cache build-base
EXPOSE 3000
WORKDIR /app
ADD Gemfile /app
ADD Gemfile.lock /app
RUN bundle config set without 'development test'
RUN bundle install
ADD . /app
