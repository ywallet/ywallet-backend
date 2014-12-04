class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.integer :balance
      t.references :account, index: true

      t.timestamps
    end
  end
end
