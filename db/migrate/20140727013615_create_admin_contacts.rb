class CreateAdminContacts < ActiveRecord::Migration
  def change
    create_table :admin_contacts do |t|
      t.string :email
      t.string :name
      t.string :contact_no
      t.text :message

      t.timestamps
    end
  end
end
