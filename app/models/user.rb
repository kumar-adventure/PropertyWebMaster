class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_attached_file :photo, :styles => { :medium => "276x276>", :thumb => "100x100>" }, :default_url => "/assets/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :name
  validates_format_of :name, :with => /\A[a-zA-Z\s]*\z/ , :message    => "can not contain a number"

  has_many :properties
  has_many :contact_requests_to_me, foreign_key: :to_user_id, class_name: "ContactRequest"
  has_many :contact_requests, foreign_key: :from_user_id, class_name: "ContactRequest"
  has_many :property_visited, class_name: "PropertyVisited"
  has_many :card_infos
  has_many :identities
  has_many :user_searches
  has_many :temp_contact_requests

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable , 
    :omniauth_providers => [:facebook, :linkedin]

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  EDUCATION = ['Primary', 'Secondary', 'Post-Secondary', 'University', 'Postgraduate or Above']
  OCCUPATION = [ 'Accounting/Audit', 'Administration/Policy', 'Civil Service', 'Education/Training',
   'Engineering/Construction', 'Environment', 'Executive/Resources Management', 'Hotel/Travel',
   'Information Technology/Technical Support', 'Insurance/Investment', 'Legal Service',
   'Media/Publishing', 'Medical Service', 'Public Relation/Advertising Marketing',
   'Social/Community Service', 'Trade/Finance/Economic/Industry', 'Transportation', 
   'Others (Please specify)' ]

  AGE = ['18', '18-25', '26-35', '36-45', '46-55', '56-65', '66-75', 'older than 75', '' ]

  MONTHLYINCOME = ['$10000' , '$10000-$20000', '$20000-$30000', '$30000-$50000', '$50000-$75000', '$75000-$100000', '>$100,000', '']

  AWARDINGINSTITUTE = ['City University of Hong Kong', 'Hong Kong Baptist University', 'Lingnan University', 'The Chinese University of Hong Kong', 'The Hong Kong Institute of Education', 'The Hong Kong Polytechnic University', 'The Hong Kong University of Science and Technology', 'The University of Hong Kong', 'The Open University of Hong Kong', 'Hong Kong Shue Yan University', 'Chu Hai College of Higher Education', 'Hang Seng Management College', 'Tung Wah College', 'Caritas Institute of Higher Education', 'Hong Kong Academy for Performing Arts', 'Centennial College', 'Other institutions in Hong Kong', 'Australia', 'Canada', 'Mainland China', 'New Zealand', 'Taiwan', 'UK', 'USA', 'Others']

  GENDER = ["Male", "Female", "Not disclosed"]
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def self.omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = 'fbTest001!'
      user.password_confirmation = 'fbTest001!'
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      user.skip_confirmation!      
    end
  end

  def age_range
    year = Time.now.year - self.date_of_birth.year

    if year < 18
      "Less then 18"
    elsif year >= 18 && year < 25
      "18 to 25"
    elsif year >= 25 && year < 45
      "25 to 45"
    elsif year >= 45 && year < 60
      "45 to 60"
    elsif year >= 60
      "More then 60"
    end
  end
end
