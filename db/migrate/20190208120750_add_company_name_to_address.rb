class AddCompanyNameToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :CompanyName, :string
  end
end
