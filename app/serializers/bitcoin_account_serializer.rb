class BitcoinAccountSerializer < ActiveModel::Serializer
  attributes :id, :access_token, :refresh_token, :expires_at, :account_id

  def access_token
  	object.access_token
  end

  def refresh_token
  	object.refresh_token
  end

  def expires_at
  	object.expires_in
  end

  def account_id
  	object.account.id
  end
  
end
