class CreatePropertyImages < ActiveRecord::Migration
  def change
    create_table :property_images do |t|
      t.references :property, index: true

      t.timestamps
    end
  end
end
