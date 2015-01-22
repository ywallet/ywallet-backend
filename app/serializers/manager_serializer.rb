class ManagerSerializer < ActiveModel::Serializer
	attributes :id, :name, :nickname, :email, :birthday, :phone, :address, :account_id, :children_ids, :balance, :transactions, :week_transactions

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

	def children_ids
		object.child_ids
	end

	def balance
		object.account.bitcoin_account.balance.to_s if (object.account != nil && object.account.bitcoin_account != nil)
	end

	def transactions
		object.account.bitcoin_account.transactions if (object.account != nil && object.account.bitcoin_account != nil)
	end

	def week_transactions
		object.account.bitcoin_account.week_transactions if (object.account != nil && object.account.bitcoin_account != nil)
	end

	#se as seguintes linhas estiverem descomentadas
	#serão apresentadas todas as propriedades de account
	#e children associadas ao manager

	#has_one :account
	#has_many :children
end
