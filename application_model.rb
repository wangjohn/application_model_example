require '~/application_model_example/model_configuration'

module ActiveRecord
  module ApplicationModel
    class ActiveRecordModelConfiguration < ActiveSupport::ModelConfiguration
      def create_defaults
        ActiveSupport::InheritableOptions.new(
          default_timezone:         :utc,
          table_name_prefix:        :rails
        )
      end
    end

    mattr_accessor :config
    self.config = ActiveRecordModelConfiguration.new
  end
end
