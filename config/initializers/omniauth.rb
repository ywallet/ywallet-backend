Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :coinbase, ENV['COINBASE_API_KEY'],   ENV['COINBASE_API_SECRET'], scope: 'user,balance,send'
end