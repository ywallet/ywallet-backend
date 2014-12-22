class ChildSerializer < ActiveModel::Serializer
	attributes :id, :name, :nickname, :email, :birthday, :phone, :address, :account_id, :wallet_id, :manager_id

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

	def wallet_id
		object.wallet.id if object.wallet != nil
	end

	def manager_id
		object.manager_id if object.manager_id != nil
	end

	#has_one :account
	#has_one :wallet, through: :account
	#belongs_to :manager
end