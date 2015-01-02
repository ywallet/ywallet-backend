class AddAccountToBitcoinAccount < ActiveRecord::Migration
  def self.up
	add_reference :bitcoin_accounts, :account, index: true
  end
  def self.down
	remove_reference :bitcoin_accounts, :account
  end
end
