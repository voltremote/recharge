class CreateStations < ActiveRecord::Migration
def self.up
create_table :stations do |t|
      t.string :name
      t.text :description
      t.string :zipcode
      t.string :street
      t.string :city
t.timestamps
    end
  end

  def self.down
    drop_table :stations
  end
end


