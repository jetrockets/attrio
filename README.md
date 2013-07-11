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

Include Attrio into your class and then use `#define_attributes` block to declare your attributes and collections.

```ruby
class User
  include Attrio
	
  define_attributes do
  	attr :name, String
    attr :age, Integer
    attr :birthday, DateTime
    collection :roles, Symbol, :unique => true
    collection :pictures, UserPicture
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
	
  define_attributes :as => 'api_attributes', collection_as: 'api_collections' do
  	attr :name, String
    attr :age, Integer
    attr :birthday, DateTime
    collection :roles, Symbol
    collection :pictures, UserPicture, unique: true, index: :filename
  end
end
```

```ruby
user = User.new
user.api_attributes # => {...}
```

### Accessing Collections
By default Attrio defines `#collections` accessor which contains `Hash` with collection names as keys and instances of `Attrio::Collection` as values.  Each instance of `Attrio::Collection` contains the following information:
 * type
 * collection reader name
 * collection reader visibility
 * add element method name
 * add element method visibility
 * find element method name
 * find element method visibility
 * has element method name
 * has element method visibility
 * empty collection method name
 * empty collection method visibility
 * reset collection method name
 * reset collection method visibility
 * initialize collection method name
 * initialize collection method visibility
 * container type
 * instance variable name
 * additional options

```ruby
user = User.new
user.collections
# => {
#     :roles => #<Attrio::Collection:0x007fc44defa680 @name='roles', @type=Symbol, @options={}, @collection_reader_name="roles", @collection_reader_visibility=:pubic, @add_element_name='add_role',@add_element_visibility=:public, @find_element_name='find_role', @find_element_name=:private, @instance_variable_name='@roles'>
#     :pictures => #<Attrio::Collection:0x007f322efa680 @name='pcitures', @type=UserPicture, @options={:unique => true, :index => :filename}, @collection_reader_name="pictures", @collection_reader_visibility=:pubic, @add_element_name='add_picture',@add_element_visibility=:public, @find_element_name='find_picture', @find_element_name=:public, @instance_variable_name='@pictures'>
# }
user.collections.keys
# => [:roles, :pictures]
```

Collections accessor can be overridden by :collections_as or :c_as

Collections with a truthy option :unique (and no :index), are created as sets.  Collections with a truthy option :unique and a :index set are created as a hash using the value returned by the method defined as :index as a key and the object as a hash.  Collections without a truthy :unique option are created as an array

### Methods for Attributes

### Methods for collections

A number of methods are added to the class for each collection entered.

```ruby
class Classroom
  include Attrio
  define_attributes do
    attr :name, String
    collection :students, Student, :unique => true, :index => :name,
               :initial_values => [{:name => "Bob"},{:name => "Kathy"}]
  end
end

my_class = Classroom.new
my_class.students            #return the collection
my_class.empty_students      #empty the collection
my_class.initialize_students #Re-add the default values to the collection
my_class.reset_students      #Empty collection then initialize with default_values
my_class.add_student("Mike") #add 1 or more elements to collection
my_class.find_student("Mike")#return element matching "Mike". For Hashes this
 is the key value, for Sets and Arrays this attempts to match the object given

my_class.has_element?("Molly")#returns true if the collection contains the
element, matched the same as find_student
```

### Default values for Attributes

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

### Initial Values for Collections

Collections support defining initial values with all the same functionality
as default values for attributes.  the option can take either a single value
or an array of them.

```ruby
class Book
  include Attrio

  DEFAULT_PAGES = [{:title => "Table of Contents },
                   {:title => "index"},
                   {:title => "Title Page"}]

  define_attributes do
    attr :content, String
    attr :views, Integer, :default => 0
    collection :pages, :unique => true, :index => :title, :initial_values =>
    DEFAULT_PAGES
  end

  def initialize(attributes = {})
    self.attributes = attributes
  end

  def attributes=(attributes = {})
    attributes.each do |attr,value|
      self.send("#{attr}=", value) if self.respond_to?("#{attr}=")
      self.send("add_#{attr}", value) if self.respond_to?("add_#{attr}")
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
You can embed both attribute and collection values in Attrio just like you do
it in Virtus.

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

## Inspect
Attrio adds its own `#inspect` method when included to the class. This
overridden method prints object attributes and collections in easy to read
manner. To disable this feature pass `:inspect => false` to `define_arguments` block.

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
