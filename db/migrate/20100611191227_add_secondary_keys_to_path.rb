class AddSecondaryKeysToPath < ActiveRecord::Migration
  def self.up
    add_column :path_sets, :map_id, :integer
    add_column :paths, :path_set_id, :integer
  end

  def self.down
    remove_column :path_sets, :map_id
    remove_column :paths, :path_set_id
  end
end
