class CreateTempContactRequests < ActiveRecord::Migration
  def change
    create_table :temp_contact_requests do |t|
      t.integer :user_id
      t.integer :property_id
      t.string :status

      t.timestamps
    end
  end
end
