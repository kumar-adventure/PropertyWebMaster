class Property < ActiveRecord::Base
  include ActionView::Helpers

  geocoded_by :full_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  scope :active, ->{ where is_active: true }

  translates :title, :short_desc, :price, :property_for, :landmark, :location, :property_in,
    :parking, :flooring, :furnishing, :open_for_inspection, :address, :city, :district, :zipcode, :available_from,
    :contact_hours, :long_desc

  #after_save :update_translations
  after_save :update_active_status

  has_attached_file :photo
  has_attached_file :agreement
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  PROPERTY_TYPES = %w(Residential Commercial Shops Industrial Land Carpark)
  LISTING_TYPES = %w(Sale Rent Lease)
  FACING = %w(East West South North South-East South-West North-East North-West)
  FLOORING = ['Ground', 'Low', 'Middle', 'High', 'Very High']
  include ActiveModel::Validations
  validates_presence_of :title, :property_type, :address
  validates_inclusion_of :property_type, in: PROPERTY_TYPES
  validates_inclusion_of :facing, in: FACING
  validates_numericality_of :saleable_area
  validates_numericality_of :gross_area

  belongs_to :user
  has_many :visits, class_name: "PropertyVisited"
  has_many :contact_requests
  has_many :temp_contact_requests
  has_many :property_comments
  has_many :property_images
  accepts_nested_attributes_for :property_images

  validate :listing_type_available

  before_save :update_listing_type


  def listing_type_available
    errors.add(:price, "Please select price for sale") if self.price.to_i == 0 && self.rent.to_i == 0
    errors.add(:rent, "Please select price for sale") if self.price.to_i == 0 && self.rent.to_i == 0
  end

  def update_listing_type
    if self.price.to_i != 0
      self.available_for_sale = true
    end
    if self.rent.to_i != 0
      self.available_for_rent = true
    end
  end

  def as_json(options)
    json = super
    json.merge({photo_url: self.photo.url,
      property_image_urls: self.property_images.collect{|x| x.photo.url }, 
      full_address: self.full_address, 
      unit_rent: unit_saleable_rent, 
      unit_price: unit_saleable_price,
      unit_gross_rent: unit_gross_rent,
      unit_gross_price: unit_gross_price,
      english_formatted_price: english_formatted_price,
      chineese_formatted_price: chineese_formatted_price
    })
  end

  def filter_search(listing_type, property_type, from_budget, to_budget, no_of_rooms)
    if listing_type != ''
      return false unless (listing_type == 'Sale' && self.available_for_sale) || (listing_type == 'Rent' && self.available_for_rent)
    end
 
    if property_type != ''
      return false unless property_type == self.property_type
    end
    
    if from_budget != ''
      return false unless (from_budget.to_i < self.price.to_i ) || ( from_budget.to_i < self.rent.to_i )
    end

    if to_budget != ''
      return false unless ( to_budget.to_i > self.price.to_i ) || ( to_budget.to_i > self.rent.to_i )
    end

    if no_of_rooms != ''
      return false unless no_of_rooms.to_i == self.total_rooms
    end

    return true
  end

  def update_active_status
    if self.user.card_infos == 0 || !self.user.confirmed?
      self.update_column(:is_active, false)
    else
      self.update_column(:is_active, true)
    end
  end
  def update_translations
    source_locale = self.posting_local
    dest_locale   = ( ["en", "zh-CN"] - [ source_locale ] ).first
    
    I18n.locale = dest_locale.to_sym

    [ :title, :short_desc, :property_for, :landmark, :location,
      :parking, :flooring, :furnishing, :open_for_inspection, :address,
      :city, :district, :contact_hours, :long_desc, :landlord_name, :other_assets
    ].each do |column|
      puts self[column]
      self.update_column(column, self[column].to_s + "_" + dest_locale.to_s ) unless self[column] == ""
    end
    I18n.locale = source_locale.to_sym
  end

  def english_formatted_price
    if self.price.to_f > 10000
      in_millian = (self.price.to_f / 1000000 ).to_f
      in_millian.round(5).to_s + ' million'
    else
      self.price
    end
  end
  def chineese_formatted_price
    if self.price.to_f > 1000
      in_bath = (self.price.to_f / 10000 ).to_f
      in_bath.round(5).to_s + ' 萬'
    else
      self.price
    end
  end

  def full_address
    [self.address, self.city, self.district, self.zipcode].join(", ")
  end

  def efficiency_ratio
    (saleable_area / gross_area).round(2)
  end

  def property_listing_for
    return "Sale & Rent" if self.available_for_rent && self.available_for_sale
    return "Sale" if self.available_for_sale
    return "Rent" if self.available_for_rent
    return "None" unless self.available_for_rent || self.available_for_sale
  end

  def applicable_amount
    return self.price if self.available_for_sale
    return self.rent if self.available_for_rent
  end

  def pending_invite_status(user_id)
    self.temp_contact_requests.where(user_id: user_id).length > 0 ? "1" : "0"
  end

  def unit_gross_price
    if gross_size && price.to_i != 0
      gross_size.to_f / price.to_i
    else
      0
    end
  end
  def unit_saleable_price
    if saleable_area && price.to_i != 0
      saleable_area.to_f / price.to_i
    else
      0
    end
  end
  def unit_gross_rent
    if gross_size && rent.to_i != 0
      gross_size.to_f / rent.to_i
    else
      0
    end
  end
  
  def unit_saleable_rent
    if saleable_area && rent.to_i != 0
      saleable_area.to_f / rent.to_i
    else
      0
    end
  end

  def post_id
    PROPERTY_ID_SPACER + self.id
  end
end
