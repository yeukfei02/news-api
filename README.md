# news-api

news-api

documentation: <https://documenter.getpostman.com/view/3827865/UVksLZKk>

api url: <https://news-api-prod.herokuapp.com/>

## Requirement

- install ruby (v3.0.3)
- install gem
- install bundle

## Testing and run

```zsh
// install ruby dependencies
$ bundle install

// run api in local
$ rails s

// create controller
$ rails g controller <controllerName>

// create model
$ rails g model <modelName>

// create migration file
$ rails g migration <migrationName>

// db migration
$ rails db:migrate

// db rollback
$ rails db:rollback

// db reset
$ rails db:migrate:reset

// list routes
$ rails routes

// run test case
$ bundle exec rspec

// rubocop
$ rubocop --auto-correct
$ rubocop -A

// reek
$ reek

// generate schema info in model
$ annotate --models

// audit Gemfile.lock
$ bundler-audit
```

## Docker

```zsh
// build images and start container in one line
docker-compose up -d --build

// run db migration in container
docker-compose exec web bundle exec rails db:migrate

// go inside container
docker exec -it <containerId> /bin/bash

// check container logs
docker logs <containerId>

// remove and stop container
docker-compose down
```

open localhost:3000