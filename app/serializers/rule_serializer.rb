class RuleSerializer < ActiveModel::Serializer
  attributes :id, :active, :notifies, :account_id

	def active
		object.active
	end

	def notifies
		object.notifies
	end

	def account_id
		object.account.id
	end

  #belongs_to :account
end
