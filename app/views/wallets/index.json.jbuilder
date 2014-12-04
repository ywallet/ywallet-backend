json.array!(@wallets) do |wallet|
  json.extract! wallet, :id, :balance, :account_id
  json.url wallet_url(wallet, format: :json)
end
