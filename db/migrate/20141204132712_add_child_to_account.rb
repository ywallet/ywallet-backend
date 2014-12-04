class AddChildToAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :child, index: true
  end
end
