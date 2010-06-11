class Point < ActiveRecord::Base
  belongs_to :path
  require 'conversions.rb'
  before_validation :convert_lat_lon
  validates_presence_of :lat, :lon
  
  def lat_sc
    degrees_to_semicircle self.lat
  end
  
  def lon_sc
    degrees_to_semicircle self.lon
  end
  
  def convert_lat_lon
    unless self.lat.nil? || is_degree?(self.lat)
     self.lat = semicircle_to_degrees self.lat
    end
    
    unless self.lon.nil? || is_degree?(self.lon)
      self.lon = semicircle_to_degrees self.lon
    end
  end
  
end
