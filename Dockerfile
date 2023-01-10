FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /weather-app-api
WORKDIR /weather-app-api

EXPOSE 3001

COPY Gemfile .
COPY Gemfile.lock .
RUN gem update bundler
RUN bundle install

CMD rails server -b 0.0.0.0