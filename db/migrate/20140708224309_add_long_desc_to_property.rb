class AddLongDescToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :long_desc, :text
  end
end
