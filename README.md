# Kinu ruby client

[Kinu](https://github.com/TakatoshiMaeda/kinu) ruby client

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kinu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kinu

## Usage

```ruby
require 'kinu'

Kinu.configure do |c|
  c.host = '127.0.0.1'
  c.port = 80
  c.ssl  = true
end

resource = Kinu::Resource.new(:foods, 1)
resource.upload(open('/path/to/image.jpg'))
resource.uri(width: 280, height: 300) # => #<URI::HTTP http://127.0.0.1/images/foods/w=280,h=300/1.jpg>

sandbox = Kinu::Sandbox.upload(open('/path/to/image.jpg'))
sandbox.uri(width: 280, height: 300) # => #<URI::HTTP http://192.168.99.100:5001/images/__sandbox__/w=280,h=300/1abd5e51-2ba4-43e5-a355-c2abee318d3f.jpg>
sandbox.attach_to(:foods, 1) # => #<Kinu::Resource:0x007fa4538098b0 @id="1", @name="foods">
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TakatoshiMaeda/kinu-ruby.

