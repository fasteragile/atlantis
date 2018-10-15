FROM ruby:2.3.7
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install rails -v '5.2.0'

RUN mkdir /app
ENV RAILS_ROOT /app
RUN mkdir -p $RAILS_ROOT/tmp/pids
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . .
