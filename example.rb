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
  p ActiveRecord::ApplicationModel
  module LegacyModule
    ApplicationModel.configs_from(LegacyModule)
    ApplicationModel.table_name_prefix = "legacy"
  end

  module NewModule
    ApplicationModel.configs_from(NewModule)
    ApplicationModel.table_name_prefix = "new"
  end

  ApplicationModel.table_name_prefix = ""

  def test_correct_name_prefixes
    assert_equal "", ApplicationModel.table_name_prefix
    assert_equal "legacy", LegacyModule.instance_exec { ApplicationModel.table_name_prefix }
    assert_equal "new", NewModule.instance_exec { ApplicationModel.table_name_prefix }
  end
end
