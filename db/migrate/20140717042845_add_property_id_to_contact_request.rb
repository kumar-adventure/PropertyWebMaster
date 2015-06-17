class AddPropertyIdToContactRequest < ActiveRecord::Migration
  def change
    add_column :contact_requests, :property_id, :integer
  end
end
