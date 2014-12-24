class ManagerSerializer < ActiveModel::Serializer
	attributes :id, :name, :nickname, :email, :birthday, :phone, :address, :account_id, :childrens_wallets, #:children_ids, :wallet_ids

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

	def childrens_wallets
		object.childrens_wallets
	end


=begin
	def children_ids
		object.child_ids
	end

	def wallet_ids
		object.wallet_ids
	end
=end



	#se as seguintes linhas estiverem descomentadas
	#serão apresentadas todas as propriedades de account,
	#wallet e children associadas ao manager

	#has_one :account
	#has_one :wallet, through: :account
	#has_many :children
end
