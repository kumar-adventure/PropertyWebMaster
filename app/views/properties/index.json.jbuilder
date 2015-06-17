json.array!(@properties) do |property|
  json.extract! property, :id, :title, :short_desc, :price, :size, :property_for, :landmark, :location, :property_in, :total_no_of_floors, :bed_rooms, :total_rooms, :bathrooms, :parking, :flooring, :furnishing, :open_for_inspection, :address, :city, :district, :zipcode, :available_from
  json.url property_url(property, format: :json)
end
