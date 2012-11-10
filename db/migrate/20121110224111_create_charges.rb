class CreateCharges < ActiveRecord::Migration
def self.up
create_table :charges do |t|
      t.string :device
      t.float :power
t.timestamps
    end
  end

  def self.down
    drop_table :charges
  end
end


