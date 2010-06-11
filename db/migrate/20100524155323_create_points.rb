class CreatePoints < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.float :lat
      t.float :lon
      t.string :description
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :points
  end
end
