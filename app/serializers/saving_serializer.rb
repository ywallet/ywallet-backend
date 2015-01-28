class SavingSerializer < ActiveModel::Serializer
  attributes :finish_date, :value, :days_left, :amount_left
  #has_one :child

  def days_left
  	object.days_left
  end

  def amount_left
  	object.amount_left
  end
end
