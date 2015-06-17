class AddOptionalFieldsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :available_for_rent, :boolean
    add_column :properties, :available_for_sale, :boolean
  end
end
