require 'test_helper'
require 'shoulda'

class MapTest < ActiveSupport::TestCase
  should_have_db_column :name
 
end
