# SwaggerYard::Rails

The SwaggerYard::Rails gem is a Rails Engine designed to parse your Yardocs API controllers using SwaggerYard. It'll create a Swagger-UI complaint JSON to be served out through where you mount SwaggerYard::Rails::Engine.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'swagger_yard-rails'
```

And then execute:

    $ bundle

## Usage

### Mount your engine ###

```ruby
# add to config/routes.rb
mount SwaggerYard::Rails::Engine, at: "/swagger"
```

### Add JS/CSS for UI ###

In your Gemfile (until the release of 2.1.3):

```ruby
gem 'swagger-ui_rails2', github: '3scale/swagger-ui_rails', branch: 'dev-2.1.3'
```

[https://github.com/3scale/swagger-ui_rails/tree/dev-2.1.3#usage](https://github.com/3scale/swagger-ui_rails/tree/dev-2.1.3#usage)

in application.css:

```css
*= require swagger-ui2/index
```

in application.js:

```js
//= require swagger-ui2/index
```

**Note:** swagger_yard-rails will handle the template

### Configure SwaggerYard ###

```ruby
# config/initializers/swagger_yard.rb
SwaggerYard.configure do |config|
  # the rest of your configuration here

  # where your swagger spec json will show up
  config.swagger_spec_base_path = "http://localhost:3000/swagger/api"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/swagger_yard-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

