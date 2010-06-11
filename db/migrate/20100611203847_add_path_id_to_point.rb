class AddPathIdToPoint < ActiveRecord::Migration
  def self.up
    add_column :points, :path_id, :integer
  end

  def self.down
    remove_column :points, :path_id
  end
end
