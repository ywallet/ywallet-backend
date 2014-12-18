Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api', format: :json }, path: '/' do
    resources :rules
    resources :wallets
    mount_devise_token_auth_for 'Account', at: '/auth'
    resources :children
    resources :managers
  end
end
