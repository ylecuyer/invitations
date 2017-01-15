FROM ruby:2.4.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && apt-get clean

WORKDIR /usr/src/app

ENV BUNDLE_PATH /ruby_gems

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
