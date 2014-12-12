class ChildSerializer < ActiveModel::Serializer
	attributes :id, :name, :email

	def name
		object.account.name
	end

	def email
		object.account.email
	end
end