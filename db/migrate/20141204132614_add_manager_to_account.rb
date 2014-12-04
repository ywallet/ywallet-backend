class AddManagerToAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :manager, index: true
  end
end
