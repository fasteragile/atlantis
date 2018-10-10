# Base image on offical version of Ruby
FROM ruby:2.3.7

# Install some required libs. May need others
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install Rails 
RUN gem install rails -v '5.2.0'

# Create application home
RUN mkdir /app

# Define where our application will live inside the image
ENV RAILS_ROOT /app

# App server pids dir
RUN mkdir -p $RAILS_ROOT/tmp/pids

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# Use the Gemfiles 
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

# Install bundler
RUN gem install bundler

# Run bundler
RUN bundle install

# Copy the Rails application into place
COPY . .