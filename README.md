# Ocar

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ocar`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ocar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ocar

## Usage

Please require the gem

```ruby
require 'ocar'
```

To get the information about a particular package.
This method will search inside all the types of packages in OCA.

```ruby
Ocar.get_package 1234456
```

And if the package exists, will return:

```ruby
@date="07/03/2015 07:22:00",
@description="Entregada",
@location="CORDOBA",
@number="0001235432",
@owner="DIAZ, Bruno",
@type="DNI">
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lucasocon/ocar.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

