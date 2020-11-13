# Ruql::Gradescope

This formatter requires [ruql](https://github.com/saasbook/ruql) and
allows formatting RuQL quizzes for use with [Gradescope](gradescope.com).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruql-gradescope'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruql-gradescope

## Usage

The simplest usage is `ruql gradescope quizfile.rb > output.gradescope`.
`ruql gradescope -h` shows formatter-specific options.

(Add more documentation here.)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

The main logic should go in `lib/ruql/gradescope/gradescope.rb`; see
comments there.

`rake build` builds the gem, `rake install:local` installs it locally
so you can try it, etc.  See `rake -T`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/saasbook/ruql-gradescope. 
