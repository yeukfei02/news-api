FROM ruby:3.0.3-alpine

ENV RAILS_ENV=production

RUN mkdir -p /app

WORKDIR /app

COPY ./ .

RUN gem install bundler

RUN bundle install

EXPOSE 3000

CMD [ "bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-e", "${RAILS_ENV}" ]