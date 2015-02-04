class CreateAllowances < ActiveRecord::Migration
  def change
    create_table :allowances do |t|
      t.integer :amount
      t.string :period
      t.references :child, index: true

      t.timestamps
    end
  end
end
