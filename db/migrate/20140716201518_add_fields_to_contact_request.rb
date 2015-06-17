class AddFieldsToContactRequest < ActiveRecord::Migration
  def change
    add_column :contact_requests, :from_user_id, :integer
    add_column :contact_requests, :to_user_id, :integer
    add_column :contact_requests, :status, :string
  end
end
