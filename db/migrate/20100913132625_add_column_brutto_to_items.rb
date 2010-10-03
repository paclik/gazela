class AddColumnBruttoToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :bruttoWeight, :Decimal
  end

  def self.down
    remove_column :items, :bruttoWeight
  end
end
