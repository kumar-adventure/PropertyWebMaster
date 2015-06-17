class AddExpirationDateToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :expiration_date, :date
  end
end
