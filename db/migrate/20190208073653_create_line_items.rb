class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.integer :quantity
      t.string :price
      t.string :discount
      t.timestamps
    end
  end
end
