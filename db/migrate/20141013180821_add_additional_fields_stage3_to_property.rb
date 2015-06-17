class AddAdditionalFieldsStage3ToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :year_build, :string
    add_column :properties, :private_garden, :boolean
    add_column :properties, :pet_allowed, :boolean
  end
end
