class AddAttachmentAgreementToProperties < ActiveRecord::Migration
  def self.up
    change_table :properties do |t|
      t.attachment :agreement
    end
  end

  def self.down
    remove_attachment :properties, :agreement
  end
end
