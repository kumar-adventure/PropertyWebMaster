class CardInfo < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :card_no, :expire_month, :expire_year, :ccv, :user_id

  validate :verify_with_stripe

  def verify_with_stripe
    begin
      token = Stripe::Token.create(
        :card => {
          :number => self.card_no,
          :exp_month => self.expire_month,
          :exp_year => self.expire_year,
          :cvc => self.ccv
        }
      )

     self.token_id        = token.id
     self.brand           = token.card.brand
     self.last4           = token.card.last4
     self.country         = token.card.country
     self.address_line1   = token.card.address_line1
     self.address_line2   = token.card.address_line2
     self.address_city    = token.card.address_city
     self.address_state   = token.card.address_state
     self.address_country = token.card.address_country
      
    rescue => exp
      errors.add(:base, "Error in validating card information")
    end    
  end
end
