class AddAttachmentAgreementToContactRequests < ActiveRecord::Migration
  def self.up
    change_table :contact_requests do |t|
      t.attachment :agreement
    end
  end

  def self.down
    drop_attached_file :contact_requests, :agreement
  end
end
