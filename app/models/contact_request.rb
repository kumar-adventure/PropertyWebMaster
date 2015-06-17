class ContactRequest < ActiveRecord::Base
  belongs_to :user, foreign_key: :from_user_id, class_name: "User"
  belongs_to :owner, foreign_key: :to_user_id, class_name: "User"
  belongs_to :property
  has_many :contact_messages
  
end
