# Get Started

## Set up
- Ensure postgres and redis are installed and running on their default ports
- Fill your database credentials on `config/database.yml`
- Install gems by running `bundle install`
- Access rails console by running `rails c`, then run `Lockbox.generate_key` and copy it to paste in Rails credentials file
- Run the following command to access Rails credentials in the environments you desire:
```sh
EDITOR="vim" rails credentials:edit --environment <env>
```
- After open Rails credentials type and replace the master key by the one generated before:
```yml
lockbox:
    master_key: "0000000000000000000000000000000000000000000000000000000000000000"
```
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
