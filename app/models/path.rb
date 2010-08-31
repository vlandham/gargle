class Path < ActiveRecord::Base
  has_one :point, :dependent => :destroy
end
