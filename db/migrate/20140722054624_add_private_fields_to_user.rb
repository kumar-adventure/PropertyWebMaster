class AddPrivateFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :highest_education, :string
    add_column :users, :yearly_income, :string
    add_column :users, :occupation, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :string
  end
end
