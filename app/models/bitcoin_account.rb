class BitcoinAccount < ActiveRecord::Base
	belongs_to :account

	def init
		user_credentials = {
			:access_token => access_token,
			:refresh_token => refresh_token,
			:expires_at => Time.now + expires_in
		}

		Coinbase::OAuthClient.new(ENV['COINBASE_API_KEY'], ENV['COINBASE_API_SECRET'], user_credentials)
	end

	def balance
		coinbase = init
		access_token = coinbase.credentials[:access_token]
		coinbase.balance
	end

end