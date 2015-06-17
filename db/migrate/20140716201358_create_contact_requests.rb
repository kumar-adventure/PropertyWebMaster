class CreateContactRequests < ActiveRecord::Migration
  def change
    create_table :contact_requests do |t|
      t.datetime :preffered_time
      t.text :note

      t.timestamps
    end
  end
end
