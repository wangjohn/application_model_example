require 'active_record'
require 'active_support'
require 'minitest/autorun'

class LegacyApplicationModel < ActiveRecord::ApplicationModel
end

class NewApplicationModel < ActiveRecord::ApplicationModel
end

class ApplicationModelTest < MiniTest::Unit::TestCase
  def test_default_prefix1
    ActiveRecord::Base.table_name_prefix = "base"
    assert_equal "base", LegacyApplicationModel.table_name_prefix
    assert_equal "base", NewApplicationModel.table_name_prefix
    assert_equal "base", ActiveRecord::ApplicationModel.table_name_prefix
    assert_equal "base", ActiveRecord::Base.table_name_prefix
  end

  def test_default_prefix2
    ActiveRecord::ApplicationModel.table_name_prefix = "application_model"
    assert_equal "application_model", LegacyApplicationModel.table_name_prefix
    assert_equal "application_model", NewApplicationModel.table_name_prefix
    assert_equal "application_model", ActiveRecord::ApplicationModel.table_name_prefix
    assert_equal "", ActiveRecord::Base.table_name_prefix
  end

  def test_default_prefix3
    NewApplicationModel.table_name_prefix = "new_application_model"
    assert_equal "", LegacyApplicationModel.table_name_prefix
    assert_equal "new_application_model", NewApplicationModel.table_name_prefix
    assert_equal "", ActiveRecord::ApplicationModel.table_name_prefix
    assert_equal "", ActiveRecord::Base.table_name_prefix
  end

  def test_default_prefix4
    LegacyApplicationModel.table_name_prefix = "legacy_application_model"
    assert_equal "legacy_application_model", LegacyApplicationModel.table_name_prefix
    assert_equal "", NewApplicationModel.table_name_prefix
    assert_equal "", ActiveRecord::ApplicationModel.table_name_prefix
    assert_equal "", ActiveRecord::Base.table_name_prefix
  end
end
