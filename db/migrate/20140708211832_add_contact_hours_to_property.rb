class AddContactHoursToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :contact_hours, :string
  end
end
