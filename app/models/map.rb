class Map < ActiveRecord::Base
  belongs_to :user
  has_many :path_sets, :dependent => :destroy
  
  def point_counts
    count = 0
    self.path_sets.each do |set|
      count += set.paths.count

end
count
  end
  
end
