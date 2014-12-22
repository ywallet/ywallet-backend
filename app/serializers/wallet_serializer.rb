class WalletSerializer < ActiveModel::Serializer
  attributes :id, :balance, :account_id, :rule_ids

	def balance
		object.balance
	end

	def account_id
		object.account.id if object.account != nil
	end

	def rule_ids
		object.rule_ids
	end

  #belongs_to :account
  #has_many :rules
end
