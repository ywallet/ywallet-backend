Rails.application.routes.draw do
  defaults format: :json do
    constraints format: :json do
      resources :rules

      resources :wallets

      mount_devise_token_auth_for 'Account', at: '/auth'
      
      resources :children

      resources :managers
      
    end
  end
end
