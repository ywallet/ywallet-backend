class RemoveWalletIdFromChildren < ActiveRecord::Migration
  def change
    remove_column :children, :wallet_id, :integer
  end
end
