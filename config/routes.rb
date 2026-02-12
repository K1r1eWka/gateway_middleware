Rails.application.routes.draw do
  namespace :gateway do
    resources :transactions, only: [ :create ]
  end
  # auth_transaction_url - route
  get "/transactions/auth/:id", to: "transactions#auth", as: :auth_transaction
  get "up" => "rails/health#show", as: :rails_health_check
end
