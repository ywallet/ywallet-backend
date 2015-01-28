Rails.application.routes.draw do
  

  resources :savings

  defaults format: :json do
    constraints format: :json do
      resources :rules

      mount_devise_token_auth_for 'Account', at: '/auth'
      
      resources :children

      resources :managers

      resources :bitcoin_accounts

      get "/transactions", to: "bitcoin_accounts#transactions"

      post "/payments", to: "bitcoin_accounts#payment"
      
    end
  end
end
