class AddLatLngToStations < ActiveRecord::Migration
  def change
    add_column :stations, :lat, :string
    add_column :stations, :lng, :string
  end
end
