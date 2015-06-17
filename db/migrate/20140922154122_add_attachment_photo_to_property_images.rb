class AddAttachmentPhotoToPropertyImages < ActiveRecord::Migration
  def self.up
    change_table :property_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :property_images, :photo
  end
end
