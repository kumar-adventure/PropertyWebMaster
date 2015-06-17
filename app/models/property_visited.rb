class PropertyVisited < ActiveRecord::Base
  belongs_to :property
  belongs_to :user

  validates_uniqueness_of :property_id, scope: :user_id
end
