class Customers::RegistrationsController < Devise::RegistrationsController
  def build_resource(hash=nil)
    hash[:uid] = Customer.create_unique_string
    super
  end
end
