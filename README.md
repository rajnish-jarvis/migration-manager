# Migration::Manager

Migration Manager is a Ruby on Rails gem that provides a web interface for managing database migrations. It allows you to view migration statuses, run pending migrations, create new tables with multiple columns, and update existing tables by adding new columns.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'migration-manager'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install migration-manager

## Configuration

To use this gem, you must remove or disable the following configuration in your environment files (development, production, or test):

```ruby
config.active_record.migration_error = :page_load  # Remove or set to false
```

Set up authentication by defining the following environment variables:

```sh
export MIGRATION_MANAGER_USER=admin
export MIGRATION_MANAGER_PASSWORD=password
```

These credentials will be required to access the Migration Manager interface securely.

## Usage

### Mounting in Routes

To mount the Migration Manager in your Rails application, add this line to your `config/routes.rb` file:

```ruby
mount MigrationManager::Engine, at: "/migration_manager"
```

For now, you must also explicitly require the gem in your application:

```ruby
require 'migration_manager'
```

We are working on making this requirement unnecessary in future versions.

## Features

- **View all migration statuses** – See pending and applied migrations.
- **Run pending migrations** – Apply database changes directly from the interface.
- **Create tables with multiple columns** – Generate new tables with configurable columns.
- **Update existing tables** – Add new columns to existing tables with ease.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run:

```sh
bundle exec rake install
```

To release a new version, update the version number in `version.rb`, and then run:

```sh
bundle exec rake release
```

This will create a git tag for the version, push git commits and tags, and upload the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [Migration Manager Repository](https://github.com/[USERNAME]/migration-manager). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/migration-manager/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Migration::Manager project's codebases, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/migration-manager/blob/master/CODE_OF_CONDUCT.md).

