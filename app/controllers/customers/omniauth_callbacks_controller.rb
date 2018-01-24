class Customers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google
    @customer = Customer.find_for_google(request.env['omniauth.auth'])

    if @customer.persisted?
      sign_in_and_redirect @customer, event: :authentication
      set_flash_message(:notice, :success, kind: "google") if is_navigational_format?
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_customer_registration_url
    end
  end

  def facebook
    @customer = Customer.find_for_facebook_oauth(request.env["omniauth.auth"], current_customer)

    if @customer.persisted?
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      sign_in_and_redirect @customer, event: :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_customer_registration_url
    end
  end
end