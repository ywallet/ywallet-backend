class CreateBitcoinAccounts < ActiveRecord::Migration
  def change
    create_table :bitcoin_accounts do |t|
      t.string :access_token, :null => false
      t.string :refresh_token, :null => false
      t.datetime :expires_in, :null => false
      t.timestamps
    end
  end
end
