class AddAddressToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :address, :string
  end
end
