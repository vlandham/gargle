class Point < ActiveRecord::Base
  require 'conversions.rb'
  
  belongs_to :path
  before_validation :convert_lat_lon
  validates_presence_of :lat, :lon
  after_destroy :destroy_associated_path
  
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
  
  def formatted_description
    des = self.name ? self.name.to_s : ""
    des += "<b>lat:</b> #{self.lat_sc}<br/><b>lon: </b>#{self.lon_sc}"
    if self.description
      des += "<br/>" + self.description
    end
    des
  end
  
  def to_marker( icon )
    title = self.name ? self.name : ""
    description = self.formatted_description
    GMarker.new(self.location,:title => title, :info_window => description, :icon => icon)
  end
  
  def location
    [self.lat, self.lon]
  end
  
  private
  
  def destroy_associated_path
    self.path.destroy if self.path
  end
  
end
