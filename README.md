# Stack

* Ruby on Rails for REST API
* AngularJS client
* PostgreSQL
* Tests with rspec, capybara and selenium

# Development setup
  
  Create DB user & add info to database.yml:

    username: ltr
    password: ltr

  Then:
  
    rake db:create
    rake db:migrate
    rails server

# Tests

## API request specs

    rake spec:requests

## Integration tests

    rake spec:features

# Deployment to Heroku

## Deployment

    heroku create
    git push heroku master

## Setup

    heroku run rake db:migrate
