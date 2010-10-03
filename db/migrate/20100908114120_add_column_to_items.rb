class AddColumnToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :place_id, :integer
  end

  def self.down
    remove_column :items, :place_id
  end
end
