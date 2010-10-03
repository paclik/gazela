class AddColumnPlaceDatumToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :placeSince, :datetime
  end

  def self.down
    remove_column :items, :placeSince
  end
end
