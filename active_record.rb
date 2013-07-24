require '~/application_model_example/application_model'

module ActiveRecord
  class Base
    def self.configuration_accessor(name)
      class_eval do
        define_singleton_method("#{name}=") do |val|
          ActiveRecord::ApplicationModel.config.send("#{name}=", val)
        end

        define_singleton_method(name) do
          ActiveRecord::ApplicationModel.config.send(name)
        end
      end
    end

    configuration_accessor :default_timezone
    p self.default_timezone
    self.default_timezone = 10
    p self.default_timezone
  end
end
