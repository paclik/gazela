class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :id
      t.string :itemid
      t.float :diameter
      t.float :width
      t.integer :weight
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
