require 'test_helper'
require 'shoulda'

class PointTest < ActiveSupport::TestCase
  should_have_db_column :name
  should_have_db_column :lat
  should_have_db_column :lon
  should_have_db_column :description
  should_validate_presence_of :lat, :lon
  should_have_instance_methods :lat_sc, :lon_sc
  
  context "Point Instance" do
    setup do
      @location = {:lat => {:degree => 35.9995257854462, :semi => 429491072}, 
                   :lon => {:degree => -102.048740386963, :semi => -1217488896}}
    end
  
    should "convert semicircle lat lon to degrees on create" do
      semi_deg = Point.create(:lat => @location[:lat][:semi], :lon => @location[:lon][:semi])
      assert_in_delta @location[:lat][:degree], semi_deg.lat, 0.00001
      assert_in_delta @location[:lon][:degree], semi_deg.lon, 0.00001
    end
    
    should "convert degree lat lon to semi circles" do
      point_deg = Point.create(:lat => @location[:lat][:degree], :lon => @location[:lon][:degree])
      assert_equal point_deg.lat_sc, @location[:lat][:semi]
      assert_equal point_deg.lon_sc, @location[:lon][:semi]
    end
  end
  
end
