class CreatePropertyTranslations < ActiveRecord::Migration
  def up 
    Property.create_translation_table!({
      title: :string,
      short_desc: :text,
      price: :string,
      property_for: :string,
      landmark: :string,
      location: :string,
      property_in: :string,
      parking: :string,
      flooring: :string,
      furnishing: :string,
      open_for_inspection: :string,
      address: :string,
      city: :string,
      district: :string,
      zipcode: :string,
      available_from: :string
    }, {
      migrate_data: true
    })
  end
  
  def down
    Property.drop_translation_table! :migrate_data => true
  end
end
