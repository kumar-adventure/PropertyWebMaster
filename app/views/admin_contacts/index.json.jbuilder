json.array!(@admin_contacts) do |admin_contact|
  json.extract! admin_contact, :id, :email, :name, :contact_no, :message
  json.url admin_contact_url(admin_contact, format: :json)
end
