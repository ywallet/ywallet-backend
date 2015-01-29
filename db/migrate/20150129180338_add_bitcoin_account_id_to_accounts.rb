class AddBitcoinAccountIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :bitcoin_account_id, :integer
    add_index :accounts, :bitcoin_account_id, name: "index_accounts_on_bitcoin_account_id"
  end
end
