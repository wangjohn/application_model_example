application_model_example
=========================

For prototyping the ApplicationModel class.

## Basics

There will be a helper class inside of Active Support which defines two methods:

    config_mattr_accessor
    config_class_attribute

These two methods will replace `mattr_accessor` and `class_attribute` respectively.
These methods will will delegate all accesses to a particular configuration
to `ApplicationModel.config`. This way, completely changing and creating a new
`ApplicationModel.config` will keep the application running.

### Swapping Configurations

The `ModelConfiguration` class makes it easy to swap configurations in and out of
the fake Active Record. For example, let's say you want to make a new configuration.

```ruby
class MyClass
  config_mattr_accessor :time_zone
  self.time_zone = :utc
end

MyClass.time_zone     # => :utc

ordered_options = ActiveSupport::OrderedOptions.new(time_zone :pst)
ActiveRecord::ApplicationModel.config = ModelConfiguration.new(ordered_options)

MyClass.time_zone     # => :pst
```

### Class Methods

The `config_mattr_accessor` method creates what is equivalent to a class variable.
You can access it and change it like so:

```ruby
class MyClass
  config_mattr_accessor :time_zone
  self.time_zone = :utc
end

MyClass.timezone           # => :utc
MyClass.timezone = :pst
MyClass.timezone           # => :pst
```

The `config_class_attribute` method makes sure that subclasses which have defined
the class attribute will not affect the parent class's value of that configuration. For 
example:

```ruby
class ParentClass
  config_class_attribute :time_zone
  self.time_zone = :utc
end

class SubClass < ParentClass
  self.time_zone = :pst
end

ParentClass.time_zone    # => :utc
SubClass.time_zone       # => :pst
```


