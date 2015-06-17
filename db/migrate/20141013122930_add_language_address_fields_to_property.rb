class AddLanguageAddressFieldsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :english_address, :string
    add_column :properties, :chinese_address, :string
  end
end
