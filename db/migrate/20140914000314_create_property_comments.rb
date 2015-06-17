class CreatePropertyComments < ActiveRecord::Migration
  def change
    create_table :property_comments do |t|
      t.references :user, index: true
      t.references :property, index: true
      t.text :content

      t.timestamps
    end
  end
end
