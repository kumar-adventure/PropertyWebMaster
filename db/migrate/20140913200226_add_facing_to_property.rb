class AddFacingToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :facing, :string
  end
end
