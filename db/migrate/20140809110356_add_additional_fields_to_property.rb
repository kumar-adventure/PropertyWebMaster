class AddAdditionalFieldsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :feature, :text
    add_column :properties, :gross_area, :integer
    add_column :properties, :floor_level, :string
    add_column :properties, :facilities_and_features, :text
    add_column :properties, :vacant_or_possession, :string
    add_column :properties, :landlord_name, :string
    add_column :properties, :hkid_no, :string
    add_column :properties, :furniture_and_fittings, :integer
    add_column :properties, :electronic_appliences, :integer
    add_column :properties, :no_of_keys, :integer
    add_column :properties, :other_assets, :text
    add_column :properties, :terms_and_condition_of_sale, :text
    add_column :properties, :accept_short_lease, :boolean
    add_column :properties, :accept_shared_rent, :boolean
    add_column :properties, :require_income_proof, :boolean
    add_column :properties, :deposite, :integer
    add_column :properties, :tenancy_terms, :integer
    add_column :properties, :fixed_period, :integer
    add_column :properties, :break_clause_notice, :integer
    add_column :properties, :availability_date, :string
    add_column :properties, :rent_inclusive_of_management_fee, :boolean
    add_column :properties, :rent_inclusive_of_govt_rent, :boolean
    add_column :properties, :meter_reading, :string
  end
end
