class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.references :manager, index: true

      t.timestamps
    end
  end
end
