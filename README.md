# Get Started
Node version: v14.18.1
Ruby version: 3.0.3
## Set up
- Ensure postgres and redis are installed and running on their default ports
- Fill your database credentials on `config/database.yml`
- Install gems running `bundle install`
- Install webpacker running `rails webpacker:install`
- Set up database running `rails db:create db:migrate`
- And finally start up the sidekiq running `bundle exec sidekiq`
- Then run:
```
rails server
```

## Testing
To see tests running and working run:
```ruby
rspec --format documentation
```

For the final test (as user) you can login with a test user already created:
```
username: test
password: test123
```

And import a bunch of contacts with the sample located on `sample.csv`, using those following headers:
- name
- birthday
- telephone
- address
- card
- email
