json.array!(@rules) do |rule|
  json.extract! rule, :id, :active, :notifies, :wallet_id
  json.url rule_url(rule, format: :json)
end
