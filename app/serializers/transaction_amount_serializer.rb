class TransactionAmountSerializer < ActiveModel::Serializer
  attributes :amount, :currency
end