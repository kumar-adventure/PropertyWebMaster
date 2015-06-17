class AddAttachmentAgreementToContactMessages < ActiveRecord::Migration
  def self.up
    change_table :contact_messages do |t|
      t.attachment :agreement
    end
  end

  def self.down
    drop_attached_file :contact_messages, :agreement
  end
end
