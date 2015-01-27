class BitcoinAccount < ActiveRecord::Base
	belongs_to :account

  validates :account, presence: true

	def init
		user_credentials = {
			:access_token => access_token,
			:refresh_token => refresh_token,
			:expires_at => Time.now + expires_in
		}

    client_id = '694fc2f618facf30b3b41726ee6d0ac04c650669ca3d114cb0bae4223cecade3'
    client_secret = '3e7cfd07d829211ac50dd6486fe677ca76e965f25ad7d68e67e845e0d4a213e7'
		Coinbase::OAuthClient.new(client_id, client_secret, user_credentials)
	end

	def create_wallet name
		coinbase = init
		wallet_response = coinbase.post("/accounts", :account => { :name => name }).to_hash
		refresh! coinbase.oauth_token
		wallet_response[:account][:id]
	end

	def balance
		coinbase = init
		balance = coinbase.balance
		refresh! coinbase.oauth_token
		balance # Money (https://github.com/RubyMoney/money)
	end

	def send_money to, amount, notes=nil, options={}
		coinbase = init
		result = coinbase.send_money(to: to, amout: amount, notes: notes, options: options)
		refresh! coinbase.oauth_token
		result.success? # boolean
	end

	def transactions
		coinbase = init
		result = coinbase.transactions
		refresh! coinbase.oauth_token
		result.transactions
	end

	def week_transactions
		week_transactions = []

		ts = transactions
		ts.each do |t|
			if Date.parse(t.transaction.created_at) > Date.today.at_beginning_of_week
				week_transactions.push(t)
				#week_transactions.push(t.transaction.id)
			end
		end

		week_transactions
	end

	private

		def refresh! oauth_token
			# access_token = coinbase.credentials[:access_token]
			access_token = oauth_token.token
			refresh_token = oauth_token.refresh_token
			expires_in = oauth_token.expires_in
			save
		end

end