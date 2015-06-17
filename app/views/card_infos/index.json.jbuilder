json.array!(@card_infos) do |card_info|
  json.extract! card_info, :id, :card_no, :expire_month, :expire_year, :ccv, :user_id
  json.url card_info_url(card_info, format: :json)
end
