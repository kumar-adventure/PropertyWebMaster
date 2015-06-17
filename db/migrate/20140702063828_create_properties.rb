class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :title
      t.text :short_desc
      t.string :price
      t.integer :size
      t.integer :gross_size
      t.string :property_for
      t.string :landmark
      t.string :location
      t.string :property_in
      t.string :total_no_of_floors
      t.integer :bed_rooms
      t.integer :total_rooms
      t.integer :bathrooms
      t.string :parking
      t.string :flooring
      t.string :furnishing
      t.string :open_for_inspection
      t.string :address
      t.string :city
      t.string :district
      t.string :zipcode
      t.date :available_from

      t.timestamps
    end
  end
end
