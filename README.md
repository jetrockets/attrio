[![Build Status](https://travis-ci.org/jetrockets/attrio.png)](https://travis-ci.org/jetrockets/attrio)
[![Code Climate](https://codeclimate.com/github/jetrockets/attrio.png)](https://codeclimate.com/github/jetrockets/attrio)
[![Coverage Status](https://coveralls.io/repos/jetrockets/attrio/badge.png)](https://coveralls.io/r/jetrockets/attrio)
[![Dependency Status](https://gemnasium.com/jetrockets/attrio.png)](https://gemnasium.com/jetrockets/attrio)
[![Gem Version](https://badge.fury.io/rb/attrio.png)](http://badge.fury.io/rb/attrio)

# Attrio

Attributes for plain Ruby objects. The goal is to provide an ability to define attributes for your models without reinventing the wheel all over again. Attrio doesn't have any third-party dependencies like Virtus or ActiveAttr and does not redefine any methods inside your class, unless you want it to.

## Installation

Add this line to your application's Gemfile:

    gem 'attrio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attrio

## Usage

Include Attrio into your class and then use `#define_attributes` block to declare you attributes.

```ruby
class User
  include Attrio
	
  define_attributes do
  	attr :name, String
    attr :age, Integer
    attr :birthday, DateTime
  end
end
```

By default Attrio creates `#attributes` accessor which contains `Hash` of with attributes names as keys and instances of `Attrio::Attribute` as values. Each instance of `Attrio::Attribute` contains following information:
 * type
 * writer method name
 * writer method visibility
 * reader method name
 * reader method visibility
 * instance variable name
 * additional options
 
```ruby
user = User.new
user.attributes 
# => {
#	:name => #<Attrio::Attribute:0x007fc44e8ca680 @object=#<Class:0x007fc44e8b2b48>, @name="name", @type=String, @options={}, @writer_method_name="name=", @writer_visibility=:public, @instance_variable_name="@name", @reader_method_name="name", @reader_visibility=:public>,
#	:age => #<Attrio::Attribute:0x007fc44e8d4c98 @object=#<Class:0x007fc44e8b2b48>, @name="age", @type=Attrio::Types::Integer, @options={}, @writer_method_name="age=", @writer_visibility=:public, @instance_variable_name="@age", @reader_method_name="age", @reader_visibility=:public>,
#	:birthday = >#<Attrio::Attribute:0x007fc44e8e2e38 @object=#<Class:0x007fc44e8b2b48>, @name="birthday", @type=Attrio::Types::DateTime, @options={}, @writer_method_name="birthday=", @writer_visibility=:public, @instance_variable_name="@birthday", @reader_method_name="birthday", @reader_visibility=:public>
# }
```

Accessor name can be easily overriden by passing `:as` option to `define_attributes` block.

```ruby
class User
  include Attrio
	
  define_attributes :as => 'api_attributes' do
  	attr :name, String
    attr :age, Integer
    attr :birthday, DateTime
  end
end
```

```ruby
user = User.new
user.api_attributes # => {...}
```

## Note on Patches / Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Credits

![JetRockets](http://www.jetrockets.ru/public/logo.png)

Webmaster is maintained by [JetRockets](http://www.jetrockets.ru/en).

Contributors:

* [Igor Alexandrov](http://igor-alexandrov.github.com/)
* [Julia Egorova](https://github.com/vankiru)

## License

It is free software, and may be redistributed under the terms specified in the LICENSE file.
