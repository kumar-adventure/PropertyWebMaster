class AddContactHoursToPropertyTranslation < ActiveRecord::Migration
  def change
    add_column :property_translations, :contact_hours, :string
  end
end
