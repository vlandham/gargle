class PathSet < ActiveRecord::Base
  belongs_to :map
  has_many :paths, :dependent => :destroy, :order => "created_at DESC" 
  
  def unique_name
    "set_#{self.id}"
  end
end
