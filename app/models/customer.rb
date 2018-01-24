class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, omniauth_providers: %i(google facebook)

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_google(auth)
    customer = Customer.find_by(email: auth.info.email)
  
    unless customer
      customer = Customer.new(email: auth.info.email,
                      provider: auth.provider,
                      uid:      auth.uid,
                      password: Devise.friendly_token[0, 20],
                                   )
    end
    customer.save
    customer
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    customer = Customer.find_by(provider: auth.provider, uid: auth.uid)

    unless customer
      customer = Customer.new(provider: auth.provider,
                      uid:      auth.uid,
                      email:    auth.info.email,
                      password: Devise.friendly_token[0, 20]
      )
    end
    customer.save
    customer
  end
end
