class AddProfileFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :facebook_friend_count, :integer
    add_column :users, :about_me, :text
    add_column :users, :school, :text
  end
end
