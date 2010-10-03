class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.integer :id
      t.string :name
      t.string :location
      t.string :invicinity
      t.integer :state_id
      t.string :district
      t.text :note
      t.string :issued_who
      t.string :change_who

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
