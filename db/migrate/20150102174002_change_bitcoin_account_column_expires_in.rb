class ChangeBitcoinAccountColumnExpiresIn < ActiveRecord::Migration
  def change
    change_table :bitcoin_accounts do |t|
      t.change :expires_in, :integer, :null => false
    end
  end
end
