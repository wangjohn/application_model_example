application_model_example
=========================

For prototyping the ApplicationModel class.

### Basics

There will be a helper class inside of Active Support which defines two methods:

    configuration_accessor
    configuration_class_accessor

These two methods will replace `mattr_accessor` and `class_attribute` respectively.
The `configuration_accessor` method will delegate all accesses to a particular configuration
to `ApplicationModel.config`. This way, completely changing and creating a new
`ApplicationModel.config` will keep the application running.

The `configuration_class_accessor` method makes sure that subclasses which have defined
the class attribute will not affect the parent class's value of that configuration. For 
example:

```ruby
class ParentClass
  configuration_class_accessor :time_zone
  self.time_zone = :utc
end

class SubClass < ParentClass
  self.time_zone = :pst
end

ParentClass.time_zone    # => :utc
SubClass.time_zone       # => :pst
```


