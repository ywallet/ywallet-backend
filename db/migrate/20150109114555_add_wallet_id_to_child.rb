class AddWalletIdToChild < ActiveRecord::Migration
  def change
    add_column :children, :wallet_id, :integer
  end
end
