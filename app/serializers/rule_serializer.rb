class RuleSerializer < ActiveModel::Serializer
  attributes :id, :active, :notifies, :wallet_id

	def active
		object.active
	end

	def notifies
		object.notifies
	end

	def wallet_id
		object.wallet.id
	end

  #belongs_to :wallet
end
