class CreateCardInfos < ActiveRecord::Migration
  def change
    create_table :card_infos do |t|
      t.string :card_no
      t.integer :expire_month
      t.integer :expire_year
      t.integer :ccv
      t.integer :user_id

      t.timestamps
    end
  end
end
