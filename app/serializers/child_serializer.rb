class ChildSerializer < ActiveModel::Serializer
	attributes :id, :name, :nickname, :email, :birthday, :phone, :address, :account_id, :manager_id, :wallet_id, :token

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

	def token
		object.account.bitcoin_account if object.account != nil && object.account.bitcoin_account != nil
	end

	#has_one :account
	#belongs_to :manager
end