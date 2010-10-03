class AddColumnsToTransports < ActiveRecord::Migration
  def self.up
    add_column :transports, :loadUntilTime, :datetime
    add_column :transports, :unLoadUntilTime, :datetime
    add_column :transports, :effectiveLoadTime, :datetime
    add_column :transports, :efectiveUnLoadTime, :datetime
  end

  def self.down
    remove_column :transports, :efectiveUnLoadTime
    remove_column :transports, :effectiveLoadTime
    remove_column :transports, :unLoadUntilTime
    remove_column :transports, :loadUntilTime
  end
end
