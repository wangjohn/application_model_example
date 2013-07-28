require '~/application_model_example/application_model'

module ActiveRecord
  class Base
    def self.config_mattr_accessor(name)
      class_eval do
        define_singleton_method("#{name}=") do |val|
          ActiveRecord::ApplicationModel.config.set(name, val)
        end

        define_singleton_method(name) do
          ActiveRecord::ApplicationModel.config.get(name)
        end
      end
    end

    def self.config_class_attribute(name)
      base_class = self
      class_eval do
        define_singleton_method("#{name}=") do |val|
          subclass = ( self == base_class ? nil : self )
          ActiveRecord::ApplicationModel.config.set(name, val, subclass: subclass)
        end

        define_singleton_method(name) do
          subclass = ( self == base_class ? nil : self )
          ActiveRecord::ApplicationModel.config.get(name, subclass: subclass)
        end
      end
    end

    config_class_attribute :default_timezone
    config_mattr_accessor :table_name_prefix
    self.default_timezone = 10
    self.table_name_prefix = :john
  end

  class Subclass < Base
    self.default_timezone = 20
  end

  class AnotherSubclass < Base
    self.default_timezone = 30
  end

  p Base.default_timezone             # => 10
  p Subclass.default_timezone         # => 20
  p AnotherSubclass.default_timezone  # => 30
  p Base.table_name_prefix            # => :john
end
