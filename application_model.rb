require 'active_support/ordered_options'
require 'active_support/core_ext/module/attribute_accessors'

module ActiveRecord
  module ApplicationModel
    class ModelConfiguration
      attr_accessor :ordered_options

      def initialize(ordered_options = nil)
        @ordered_options = ordered_options || create_defaults
        @subclasses = Hash.new { |h,k| h[k] = Hash.new() }
      end

      def get(name, options = {})
        if subclass = options[:subclass]
          @subclasses[subclass][name] || @ordered_options[name]
        else
          @ordered_options[name]
        end
      end

      def set(name, value, options = {})
        if subclass = options[:subclass]
          @subclasses[subclass][name] = value
        else
          @ordered_options[name] = value
        end
      end

      private

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
