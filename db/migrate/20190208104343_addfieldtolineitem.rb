class Addfieldtolineitem < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items, :tax_rate_override, :string
    add_column :line_items, :tax_rate, :string
    add_column :orders, :currency_id, :integer
    add_column :orders, :phone_number, :string
    add_column :orders, :tags, :string
    #add_column :orders, :document_url, :string
    add_column :orders, :source_Id, :string

  end
end
