Rails.application.routes.draw do
  

  defaults format: :json do
    constraints format: :json do
      resources :rules

      mount_devise_token_auth_for 'Account', at: '/auth'
      
      resources :children

      resources :managers

      resources :bitcoin_accounts
      
    end
  end
end
