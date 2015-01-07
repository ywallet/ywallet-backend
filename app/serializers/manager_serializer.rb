class ManagerSerializer < ActiveModel::Serializer
	attributes :id, :name, :nickname, :email, :birthday, :phone, :address, :account_id, :children_ids

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



	#se as seguintes linhas estiverem descomentadas
	#serão apresentadas todas as propriedades de account,
	#wallet e children associadas ao manager

	#has_one :account
	#has_many :children
end
