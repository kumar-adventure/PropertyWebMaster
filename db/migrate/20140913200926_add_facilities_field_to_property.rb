class AddFacilitiesFieldToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :balcony, :boolean
    add_column :properties, :rooftop, :boolean
    add_column :properties, :clubhouse, :boolean
    add_column :properties, :swiming_pool, :boolean
    add_column :properties, :gym_room, :boolean
    add_column :properties, :shuttle_bus, :boolean
    add_column :properties, :sea_view, :boolean
    add_column :properties, :parking_garage, :boolean
    add_column :properties, :private_parking_space, :boolean
  end
end
