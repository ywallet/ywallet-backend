class CreateSavings < ActiveRecord::Migration
  def change
    create_table :savings do |t|
      t.date :finish_date
      t.decimal :value
      t.references :child, index: true

      t.timestamps
    end
  end
end
