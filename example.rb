require '~/rails/activerecord/lib/active_record'
require '~/rails/activesupport/lib/active_support'
require 'minitest/autorun'

module LegacyModule
  class LegacyApplicationModel < ActiveRecord::ApplicationModel
    configs_from(LegacyModule)
  end

  class LegacyApplicationModelTest < MiniTest::Unit::TestCase
    def setup
      LegacyApplicationModel.table_name_prefix = "legacy"
    end

    def test_default_prefix
      assert_equal "legacy", ActiveRecord::ApplicationModel.get_config("table_name_prefix", self)
    end

    def test_changing_prefix_using_constant
      LegacyApplicationModel.table_name_prefix = "hello"
      assert_equal "hello", ActiveRecord::ApplicationModel.get_config("table_name_prefix", self)
    end

    def test_setting_prefix
      ActiveRecord::ApplicationModel.set_config("table_name_prefix", "noooo", self)
      assert_equal "noooo", ActiveRecord::ApplicationModel.get_config("table_name_prefix", self)
    end
  end
end

module NewModule
  class NewApplicationModel < ActiveRecord::ApplicationModel
    configs_from(NewModule)
  end

  class NewApplicationModelTest < MiniTest::Unit::TestCase
    def setup
      NewApplicationModel.table_name_prefix = "new"
    end

    def test_default_prefix
      assert_equal "new", ActiveRecord::ApplicationModel.get_config("table_name_prefix", self)
    end

    def test_changing_prefix_using_constant
      NewApplicationModel.table_name_prefix = "hello"
      assert_equal "hello", ActiveRecord::ApplicationModel.get_config("table_name_prefix", self)
    end

    def test_setting_prefix
      ActiveRecord::ApplicationModel.set_config("table_name_prefix", "hihoo", self)
      assert_equal "hihoo", ActiveRecord::ApplicationModel.get_config("table_name_prefix", self)
    end
  end
end

class ApplicationModelTest < MiniTest::Unit::TestCase
  def test_default_prefix
    assert_equal "", ActiveRecord::ApplicationModel.table_name_prefix
  end

  def test_default_prefix_with_get_config
    assert_equal "", ActiveRecord::ApplicationModel.get_config("table_name_prefix", self)
  end
end

