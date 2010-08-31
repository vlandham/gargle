class PathSet < ActiveRecord::Base
  belongs_to :map
  has_many :paths, :dependent => :destroy
end
