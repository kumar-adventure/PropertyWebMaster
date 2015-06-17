class PropertyImage < ActiveRecord::Base
  belongs_to :property

  has_attached_file :photo
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:photo_file_name),
      "size" => read_attribute(:photo_file_size),
      "url" => self.photo.url(:original),
      "delete_url" => "/properties/#{self.property.id}/remove_image?image_id=#{self.id}",
      "delete_type" => "DELETE" 
    }
  end
end
