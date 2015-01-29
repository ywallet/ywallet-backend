class RuleSerializer < ActiveModel::Serializer
  attributes :id, :amount, :period, :active, :notifies, :account_id

	def account_id
		object.account.id
	end

  #belongs_to :account
end
