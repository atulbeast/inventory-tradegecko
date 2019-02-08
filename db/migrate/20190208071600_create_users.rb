class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :address_one
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :email
      t.integer :uid
      t.boolean :tax_exempt
      t.boolean :tax_exempt_approved
      t.boolean :commercial 
      t.timestamps
    end
    add_index :users, :uid, unique: true
  end
end
