json.array!(@property_comments) do |property_comment|
  json.extract! property_comment, :id, :user_id, :property_id, :content
  json.url property_comment_url(property_comment, format: :json)
end
