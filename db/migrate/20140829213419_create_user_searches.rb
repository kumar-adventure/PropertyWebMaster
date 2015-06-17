class CreateUserSearches < ActiveRecord::Migration
  def change
    create_table :user_searches do |t|
      t.references :user, index: true
      t.string :query
      t.string :listing_type
      t.string :property_type
      t.integer :min_budget
      t.integer :max_budget
      t.integer :no_of_rooms

      t.timestamps
    end
  end
end
