class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.timestamp :entry_date
    end
    add_index :orders, :order_id, unique: true
  end
end
