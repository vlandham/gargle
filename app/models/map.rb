class Map < ActiveRecord::Base
  belongs_to :user
  has_many :path_sets, :dependent => :destroy
  
end
