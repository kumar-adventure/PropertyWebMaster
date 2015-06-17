class AddAgreementLaterSentToContactRequest < ActiveRecord::Migration
  def change
    add_column :contact_requests, :agreement_letter_sent, :boolean, default: false
  end
end
