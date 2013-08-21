require '~/rails/activerecord/lib/active_record'
require '~/rails/activesupport/lib/active_support'
require 'minitest/autorun'

# In this use case, there are two modules, <tt>LegacyModule</tt> and <tt>NewModule</tt>
# which both have a database connection. The <tt>LegacyModule</tt> has a connection
# to the legacy database, while the <tt>NewModule</tt> has a connection to the new
# database.
#
# When we look at the <tt>ActiveRecord</tt> constants, we see that the <tt>table_name_prefix</tt>
# constant should be different depending on which module things are coming from. When
# inside of the <tt>LegacyModule</tt>, the prefix should be "legacy". When inside of
# the <tt>NewModule</tt>, the prefix should be "new". Otherwise, the default prefix is
# the empty string when not inside either of these two modules.
class ApplicationModelTest < MiniTest::Unit::TestCase
  module LegacyModule
    class LegacyApplicationModel < ActiveRecord::ApplicationModel
      configs_from(LegacyModule)

      self.table_name_prefix = "legacy"
    end

    p ActiveRecord::ApplicationModel.get_config("table_name_prefix", self)
  end

  module NewModule
    class NewApplicationModel < ActiveRecord::ApplicationModel
      configs_from(NewModule)

      self.table_name_prefix = "new"
    end
  end

  ActiveRecord::ApplicationModel.table_name_prefix = ""

  def test_default_prefix
    assert_equal "", ActiveRecord::ApplicationModel.table_name_prefix
  end
end

