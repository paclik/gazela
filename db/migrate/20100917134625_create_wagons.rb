class CreateWagons < ActiveRecord::Migration
  def self.up
    create_table :wagons do |t|
      t.integer :id
      t.string :vrn
      t.string :wag_type
      t.integer :item_id
      t.integer :transport_id

      t.timestamps
    end
  end

  def self.down
    drop_table :wagons
  end
end
