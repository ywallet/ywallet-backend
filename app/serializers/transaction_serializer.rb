class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :amount, :status, :sender, :recipient

  def amount
    TransactionAmountSerializer.new(object.amount, root: false)
  end

  def sender
    TransactionUserSerializer.new(object.sender, root: false)
  end

  def recipient
    TransactionUserSerializer.new(object.recipient, root: false)
  end

end