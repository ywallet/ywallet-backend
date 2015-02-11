class ChildSerializer < ActiveModel::Serializer
	attributes :id, :name, :nickname, :email, :birthday, :phone, :address, :account_id, :manager_id, :rule_ids, :wallet_id, :balance, :bitcoin_address, :transactions, :week_transactions

	def name
		object.account.name if object.account != nil
	end

	def nickname
		object.account.nickname if object.account != nil
	end

	def email
		object.account.email if object.account != nil
	end

	def birthday
		object.account.birthday if object.account != nil
	end

	def phone
		object.account.phone if object.account != nil
	end

	def address
		object.account.address if object.account != nil
	end

	def account_id
		object.account.id if object.account != nil
	end

	def manager_id
		object.manager_id if object.manager_id != nil
	end

	def rule_ids
		if object.account != nil
			object.account.rule_ids
		end
	end

	def allowance_ids
		object.allowance_ids
	end

	def balance
		if (object.account != nil && object.account.bitcoin_account != nil)
			object.account.bitcoin_account.wallet_balance(object.wallet_id).to_s
		end
	end

	def bitcoin_address
		if (object.account != nil && object.account.bitcoin_account != nil)
			object.account.bitcoin_account.address(object.wallet_id)
		end
	end

	def transactions
		object.account.bitcoin_account.transactions if (object.account != nil && object.account.bitcoin_account != nil)
	end

	def week_transactions
		object.account.bitcoin_account.week_transactions if (object.account != nil && object.account.bitcoin_account != nil)
	end

	#has_one :account
	#belongs_to :manager
end