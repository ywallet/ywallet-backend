class AddWalletIdToChildren < ActiveRecord::Migration
  def change
    add_column :children, :wallet_id, :string
  end
end
