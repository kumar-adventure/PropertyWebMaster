json.array!(@contact_messages) do |contact_message|
  json.extract! contact_message, :id, :content, :user_id, :contact_request_id
  json.url contact_message_url(contact_message, format: :json)
end
