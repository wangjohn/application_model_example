require 'active_support/ordered_options'
require 'active_support/core_ext/module/attribute_accessors'

module ActiveRecord
  module ApplicationModel
    class ModelConfiguration
      attr_accessor :ordered_options

      def initialize(ordered_options = nil)
        @ordered_options = ordered_options || create_defaults
      end

      def method_missing(name, *args)
        self.class.create_accessor(name)
        send(name, *args)
      end

      def respond_to_missing?(name, include_private)
        true
      end

      private

        def self.create_accessor(name)
          define_method(name) do |*args|
            @ordered_options.send(name, *args)
          end
        end

        def create_defaults
          ActiveSupport::InheritableOptions.new(
            default_timezone:                         :utc,
          )
        end
    end

    mattr_accessor :config
    self.config = ModelConfiguration.new
  end
end
