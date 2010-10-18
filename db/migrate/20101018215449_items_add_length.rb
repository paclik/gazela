class ItemsAddLength < ActiveRecord::Migration
  def self.up
    add_column :items, :length, :float
  end

  def self.down
    remove_column :items, :length
  end
end
