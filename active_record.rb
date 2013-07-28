require '~/application_model_example/application_model'
require '~/application_model_example/config_accessors'

module ActiveRecord
  class Base
    include ActiveSupport::ConfigAccessors

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
