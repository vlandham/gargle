class CreatePathSets < ActiveRecord::Migration
  def self.up
    create_table :path_sets do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :path_sets
  end
end
