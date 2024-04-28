FROM ruby:3.2.2
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \ 
    nodejs \
    postgresql-client \
    yarn
RUN mkdir workdir
WORKDIR /workdir
ADD Gemfile /workdir/Gemfile
ADD Gemfile.lock /workdir/Gemfile.lock
RUN bundle install
ADD . /workdir/