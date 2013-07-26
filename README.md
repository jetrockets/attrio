[![Build Status](https://travis-ci.org/jetrockets/attrio.png)](https://travis-ci.org/jetrockets/attrio)
[![Code Climate](https://codeclimate.com/github/jetrockets/attrio.png)](https://codeclimate.com/github/jetrockets/attrio)
[![Coverage Status](https://coveralls.io/repos/jetrockets/attrio/badge.png)](https://coveralls.io/r/jetrockets/attrio)
[![Dependency Status](https://gemnasium.com/jetrockets/attrio.png)](https://gemnasium.com/jetrockets/attrio)
[![Gem Version](https://badge.fury.io/rb/attrio.png)](http://badge.fury.io/rb/attrio)

# Attrio

Attributes for plain Ruby objects. The goal is to provide an ability to define attributes for your models without reinventing the wheel all over again. Attrio doesn't have any third-party dependencies like [Virtus](https://github.com/solnic/virtus) or [ActiveAttr](https://github.com/cgriego/active_attr) and does not redefine any methods inside your class, unless you want it to.

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
### Accessing attributes
By default Attrio defines `#attributes` accessor which contains `Hash` with attributes names as keys and instances of `Attrio::Attribute` as values. Each instance of `Attrio::Attribute` contains following information:
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
#	:name => #<Attrio::Attribute:0x007fc44e8ca680 @object=#<User:0x007fc44e8b2b48>, @name="name", @type=String, @options={}, @writer_method_name="name=", @writer_visibility=:public, @instance_variable_name="@name", @reader_method_name="name", @reader_visibility=:public>,
#	:age => #<Attrio::Attribute:0x007fc44e8d4c98 @object=#<User:0x007fc44e8b2b48>, @name="age", @type=Attrio::Types::Integer, @options={}, @writer_method_name="age=", @writer_visibility=:public, @instance_variable_name="@age", @reader_method_name="age", @reader_visibility=:public>,
#	:birthday = >#<Attrio::Attribute:0x007fc44e8e2e38 @object=#<User:0x007fc44e8b2b48>, @name="birthday", @type=Attrio::Types::DateTime, @options={}, @writer_method_name="birthday=", @writer_visibility=:public, @instance_variable_name="@birthday", @reader_method_name="birthday", @reader_visibility=:public>
# }
user.attributes.keys
# => [:name, :age, :birthday]
```

Attributes can be filtered.

```ruby
user.attributes([:name, :age, :not_existing_attribute]).keys
# => [:name, :age]
```

Accessor name can be easily overridden by passing `:as` option to `define_attributes` block.

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

### Default values

Attrio supports all the ways to setup default values that Virtus has.

```ruby
class Page
  include Attrio

  define_attributes do
    attr :title, String

    # default from a singleton value (integer in this case)
    attr :views, Integer, :default => 0

    # default from a singleton value (boolean in this case)
    attr :published, Boolean, :default => false

    # default from a callable object (proc in this case)
    attr :slug, String, :default => lambda { |page, attribute| page.title.present? ? page.title.downcase.gsub(' ', '-') : nil }

    # default from a method name as symbol
    attr :editor_title, String,  :default => :default_editor_title
  end
  
  def initialize(attributes = {})
    self.attributes = attributes
  end

  def attributes=(attributes = {})
    attributes.each do |attr,value|
      self.send("#{attr}=", value) if self.respond_to?("#{attr}=")
    end
  end

  def default_editor_title
    if self.published?
      title
    else
      title.present? ? "UNPUBLISHED: #{title}" : "UNPUBLISHED"
    end    
  end
end
```

### Embed Value
You can embed values in Attrio just like you do it in Virtus.

```ruby
module MassAssignment
  def initialize(attributes = {})
    self.attributes = attributes
  end

  def attributes=(attributes = {})
    attributes.each do |attr,value|
      self.send("#{attr}=", value) if self.respond_to?("#{attr}=")
    end
  end
end

class City  
  include Attrio
  include MassAssignment

  define_attributes do
    attr :name, String
  end
end

class Address
  include Attrio
  include MassAssignment

  define_attributes do
    attr :street,  String
    attr :zipcode, String
    attr :city,    City
  end
end

class User
  include Attrio
  include MassAssignment

  define_attributes do
    attr :name,    String
    attr :address, Address
  end
end

user = User.new( :address => { :street => 'Sklizkova 6A', :zipcode => '170000', :city => { :name => 'Tver' } } )
user.address.street
# => 'Sklizkova 6A'
user.address.zipcode
# => '170000'
user.address.city.name
# => 'Tver'
```

### Methods visibility

Don't want your accessors to be public? Visibility can be overridden easily. 

```ruby
class User
  include Attrio
	
  define_attributes do
  	attr :name, String, :writer => :protected
    attr :secret_rating, Integer, :reader => :private
  end
end
```

### Types

Any Ruby class can be passed as type to Attrio. If this class responds to `typecast` and `typecasted?` methods then they will be called, else `new` will be called.

```ruby
class Klass
  include Attrio
	
  define_attributes do  	
  	attr :custom_attribute, CustomClass
  end
end
```

### Built-in Types

**Boolean**

By default boolean typecasts 'yes', '1', 1, 'true' as `TrueClass` and all other values as `FalseClass`, but you easily modify this behaviour.

```ruby
class Klass
  include Attrio
	
  define_attributes do
  	attr :boolean_attribute, Boolean
  	
  	attr :custom_boolean_attribute, Boolean, :yes => ['ja', '1', 1]
  	# attr :custom_boolean_attribute, Boolean, :yes_values => ['ja', '1', 1]
  	# attr :custom_boolean_attribute, Boolean, :no => ['nein', '0', 0]
  	# attr :custom_boolean_attribute, Boolean, :no_values => ['nein', '0', 0]
  end
end
```

**Date, Time and DateTime**

These three class have similar behaviour and options. By passing `:format` option you can setup how `strftime` method will try to parse your string.

```ruby
class Klass
  include Attrio
	
  define_attributes do
  	attr :date_attribute, Date
  	attr :time_attribute, Time
  	attr :date_time_attribute, DateTime
  	
	attr :custom_date_time_attribute, DateTime, :format => '%m/%d/%y-%H:%M:%S-%z'
  end
end
```

**Float**

Attribute will be typecasted using `to_f` method.

```ruby
class Klass
  include Attrio
	
  define_attributes do
  	attr :float_attribute, Float
  end
end
```

**Integer**

Attribute will be typecasted using `to_i` method.

Optional `:base` parameter can be passed, during the typecast attribute will be assumed to be in specified base and will always be translated to decimal base.

```ruby
class Klass
  include Attrio
	
  define_attributes do
  	attr :integer_attribute, Integer
  	attr :custom_integer_attribute, Integer, :base => 2
  end
end
```

**Symbol**

Attribute will be typecasted using `to_sym` method.

If Optional `:underscore` parameter is passed, then attribute value will be downcased and underscored before calling `to_sym`. 

```ruby
class Klass
  include Attrio
	
  define_attributes do
  	attr :symbol_attribute, Symbol
  	attr :custom_symbol_attribute, Symbol, :underscore => true
  end
end
```

**Array**

Arrays are designed to automatically handle collections of objects (that also can be typecasted)

If value that should be typecasted responds to `split`, then this method is called with default (or overriden) attributes, else `Array` is wrapped on value. You can easily handle types and options of collection elements.

```ruby
class Klass
  include Attrio

  define_attributes do
	attr :array_attribute, Array
    attr :custom_array_attribute, Array, :split => ', ', :element => { :type => Date, :options => { :format => '%m/%d/%y' } }
  end
end
```

## Inspect
Attrio adds its own `#inspect` method when included to the class. This overridden method prints object attributes in easy to read manner. To disable this feature pass `:inspect => false` to `define_arguments` block.

```ruby
class Klass
  include Attrio
	
  define_attributes :inspect => false do
  	attr :attribute, String
  end
end
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
