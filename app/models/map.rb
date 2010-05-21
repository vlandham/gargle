class Map < ActiveRecord::Base
  belongs_to :user
  
  attr_accessor :user
end
