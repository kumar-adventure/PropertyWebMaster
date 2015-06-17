class AddCardDetailsToCardInfo < ActiveRecord::Migration
  def change
    add_column :card_infos, :token_id, :string
    add_column :card_infos, :brand, :string
    add_column :card_infos, :last4, :string
    add_column :card_infos, :country, :string
    add_column :card_infos, :name, :string
    add_column :card_infos, :address_line1, :string
    add_column :card_infos, :address_line2, :string
    add_column :card_infos, :address_city, :string
    add_column :card_infos, :address_state, :string
    add_column :card_infos, :address_zip, :string
    add_column :card_infos, :address_country, :string
  end
end
