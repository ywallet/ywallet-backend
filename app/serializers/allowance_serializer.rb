class AllowanceSerializer < ActiveModel::Serializer
  attributes :id, :amount, :period, :child_id

  def child_id
    object.child.id if object.child != nil
  end

  #has_one :child
end
