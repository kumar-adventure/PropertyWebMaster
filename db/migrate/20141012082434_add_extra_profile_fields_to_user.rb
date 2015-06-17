class AddExtraProfileFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :age, :string
    add_column :users, :allowing_institution, :string
    add_column :users, :monthly_income, :string
  end
end
