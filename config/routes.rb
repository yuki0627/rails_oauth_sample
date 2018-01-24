Rails.application.routes.draw do
  get 'oauth/index'

  devise_for :customers, controllers: {
    registrations: "customers/registrations",
    omniauth_callbacks: "customers/omniauth_callbacks"
  }
end
