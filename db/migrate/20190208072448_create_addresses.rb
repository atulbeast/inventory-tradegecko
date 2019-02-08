class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name 
      t.string :address_one
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :uid
      t.boolean :tax_exempt
      t.boolean :tax_exempt_approved
      t.boolean :commercial
      t.integer :address_id
      t.boolean :flag
      t.integer :key
      t.timestamps
    end
  end
end
