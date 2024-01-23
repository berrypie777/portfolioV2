FROM ruby:3.2.2
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
    yarn && \
    mkdir /docker-rails

WORKDIR /docker-rails
COPY Gemfile /docker-rails/Gemfile
COPY Gemfile.lock /docker-rails/Gemfile.lock
RUN bundle install
COPY . /docker-rails

RUN rm -f tmp/pids/server.pid

CMD ["rails", "server", "-b", "0.0.0.0"]
