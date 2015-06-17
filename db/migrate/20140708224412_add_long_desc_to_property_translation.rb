class AddLongDescToPropertyTranslation < ActiveRecord::Migration
  def change
    add_column :property_translations, :long_desc, :text
  end
end
