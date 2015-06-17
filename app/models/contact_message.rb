class ContactMessage < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact_request

  has_attached_file :agreement
end
