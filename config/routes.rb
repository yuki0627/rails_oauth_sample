Rails.application.routes.draw do
  root :to => 'oauth#index'

  devise_for :customers, controllers: {
    registrations: "customers/registrations",
    omniauth_callbacks: "customers/omniauth_callbacks"
  }
end
