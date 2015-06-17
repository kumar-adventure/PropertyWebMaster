class AddPhoneVerificationStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_verification_status, :string, default: 'Pending'
  end
end
