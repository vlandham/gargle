class PathSet < ActiveRecord::Base
  belongs_to :map
  has_many :paths
end
