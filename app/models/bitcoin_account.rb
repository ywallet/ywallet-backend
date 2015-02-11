class BitcoinAccount < ActiveRecord::Base

	has_many :accounts # this is actually a 'belongs_to_many' relation...

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
		wallet_response = coinbase.post("/accounts", :account => { :name => "ywallet_#{name}" }).to_hash
		refresh! coinbase.oauth_token
		wallet_response["account"]["id"]
	end

	def name
		coinbase = init
		user_response = coinbase.get("/users/self").to_hash
		refresh! coinbase.oauth_token
		user_response["user"]["name"]
	end

	def balance
		coinbase = init
		balance = coinbase.balance
		refresh! coinbase.oauth_token
		balance # Money (https://github.com/RubyMoney/money)
	end

	def address wallet_id=nil
		coinbase = init
		url = "/accounts/#{wallet_id}/address"
		address_result = coinbase.get(url).to_hash
		refresh! coinbase.oauth_token
		address_result["address"]
	end

	def wallet_balance wallet_id
		coinbase = init
		url = "/accounts/#{wallet_id}/balance"
		balance_response = coinbase.get(url)
		refresh! coinbase.oauth_token
		balance_response['amount'].to_money(balance_response['currency']) # Money (https://github.com/RubyMoney/money)
	end


	def send_money to, amount, notes=nil, options={}
		coinbase = init
		result = coinbase.send_money(to: to, amout: amount, notes: notes, options: options)
		refresh! coinbase.oauth_token
		result.success? # boolean
	end
	

	def transactions wallet_id=nil
		coinbase = init
		options = { :limit => 100 }
		if wallet_id != nil
			options = options.merge(:account_id => wallet_id)
		end
		result = coinbase.transactions(options)
		refresh! coinbase.oauth_token
		result.transactions
	end

	def day_transactions wallet_id=nil
		day_transactions = []

		ts = transactions(wallet_id)
		ts.each do |t|
			if Date.parse(t.transaction.created_at) > Date.today.at_beginning_of_day
				day_transactions.push(t.transaction)
			end
		end

		day_transactions
	end

	def week_transactions wallet_id=nil
		week_transactions = []

		ts = transactions(wallet_id)
		ts.each do |t|
			if Date.parse(t.transaction.created_at) > Date.today.at_beginning_of_week
				week_transactions.push(t.transaction)
				#week_transactions.push(t.transaction.id)
			end
		end

		week_transactions
	end

	def month_transactions wallet_id=nil
		month_transactions = []

		ts = transactions(wallet_id)
		ts.each do |t|
			if Date.parse(t.transaction.created_at) > Date.today.at_beginning_of_month
				month_transactions.push(t.transaction)
			end
		end

		month_transactions
	end


	def day_expenses wallet_id=nil
		calc_expenses_of(day_transactions(wallet_id))
	end

	def week_expenses wallet_id=nil
		calc_expenses_of(week_transactions(wallet_id))
	end

	def month_expenses wallet_id=nil
		calc_expenses_of(month_transactions(wallet_id))
	end


	private

		def calc_expenses_of transactions
			total = 0

			transactions.each do |t|
				total += t.amount.amount if t.amount.currency == "BTC"
			end

			total
		end

		def refresh! oauth_token
			# access_token = coinbase.credentials[:access_token]
			access_token = oauth_token.token
			refresh_token = oauth_token.refresh_token
			expires_in = oauth_token.expires_in
			save
		end

end