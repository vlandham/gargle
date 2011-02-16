class AddDescriptionToMap < ActiveRecord::Migration
  def self.up
    add_column :maps, :description, :text
  end

  def self.down
    remove_column :maps, :description
  end
end
