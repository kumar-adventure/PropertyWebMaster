class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.text :content
      t.references :user, index: true
      t.references :contact_request, index: true

      t.timestamps
    end
  end
end
