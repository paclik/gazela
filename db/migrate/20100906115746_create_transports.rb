class CreateTransports < ActiveRecord::Migration
  def self.up
    create_table :transports do |t|
      t.integer :id
      t.string :senderRequest
      t.integer :loadPlace_id
      t.integer :unLoadPlace_id
      t.string :vrn
      t.datetime :loadTime
      t.datetime :UnLoadTime
      t.text :note
      t.string :issued_who
      t.string :change_who

      t.timestamps
    end
  end

  def self.down
    drop_table :transports
  end
end           
