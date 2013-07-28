require 'active_support/concern'

module ActiveSupport
  module ConfigAccessors
    extend ActiveSupport::Concern

    included do
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

      def self.config_attr_accessor(name)
        class_eval do
          define_method("#{name}=") do |val|
            ActiveRecord::ApplicationModel.config.set(name, val)
          end

          define_method(name) do
            ActiveRecord::ApplicationModel.config.get(name)
          end
        end
      end
    end
  end
end
