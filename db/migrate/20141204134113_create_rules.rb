class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.boolean :active
      t.boolean :notifies
      t.references :account, index: true

      t.timestamps
    end
  end
end
