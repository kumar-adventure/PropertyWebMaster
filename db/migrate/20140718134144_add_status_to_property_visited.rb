class AddStatusToPropertyVisited < ActiveRecord::Migration
  def change
    add_column :property_visiteds, :status, :string
  end
end
