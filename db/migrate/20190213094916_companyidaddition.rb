class Companyidaddition < ActiveRecord::Migration[5.2]
  def change

    add_column :addresses, :company_id, :integer
  end
end
