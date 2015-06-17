class AddExtraFieldsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :building_name, :string
    add_column :properties, :flat, :string
    add_column :properties, :street, :string
  end
end
