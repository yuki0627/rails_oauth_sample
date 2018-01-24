Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: "customers/registrations",
    omniauth_callbacks: "customers/omniauth_callbacks"
  }
end
