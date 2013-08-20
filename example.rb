require 'active_record'
require 'minitest/autorun'

class ApplicationModelTest < MiniTest::Unit::TestCase
  module LegacyModule
    class LegacyDatabase < ActiveRecord::Base
    end

    ActiveRecord::Base.table_name_prefix = "legacy"
  end

  module NewModule
    class NewDatabase < ActiveRecord::Base
    end

    ActiveRecord::Base.table_name_prefix = "new"
  end

  ActiveRecord::Base.table_name_prefix = ""

  def test_correct_name_prefixes
    assert_equal "", ActiveRecord::Base.table_name_prefix
    assert_equal "legacy", LegacyModule.instance_eval(ActiveRecord::Base.table_name_prefix)
    assert_equal "new", NewModule.instance_eval(ActiveRecord::Base.table_name_prefix)
  end
end
