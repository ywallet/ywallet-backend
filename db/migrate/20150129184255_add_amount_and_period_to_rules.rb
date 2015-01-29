class AddAmountAndPeriodToRules < ActiveRecord::Migration
  def change
    add_column :rules, :amount, :integer
    add_column :rules, :period, :string
  end
end
