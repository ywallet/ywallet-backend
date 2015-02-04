class RemoveAccountIdFromBitcoinAccounts < ActiveRecord::Migration
  def change
    remove_index :bitcoin_accounts, :account_id
    remove_column :bitcoin_accounts, :account_id, :integer
  end
end
