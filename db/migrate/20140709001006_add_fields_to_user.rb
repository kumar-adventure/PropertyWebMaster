class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :contact_no, :string
    add_column :users, :mail_notification, :boolean
  end
end
