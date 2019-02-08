class AddFieldsToOrderTbl < ActiveRecord::Migration[5.2]
  def change
    add_column :orders,:billing_address_id, :integer
    add_column :orders,:user_id,:integer
    add_column :orders,:assignee_id,:integer
    add_column :orders,:default_price_list_id,:string
    add_column :orders,:order_number,:string
    add_column :orders,:order_line_item_ids,:string
    add_column :orders,:notes,:string
    add_column :orders,:reference_number,:string
    add_column :orders,:status,:string
    add_column :orders,:packed_status,:string
    add_column :orders,:fulfillment_status,:string
    add_column :orders,:invoice_status,:string
    add_column :orders,:payment_status,:string
    add_column :orders,:return_status,:string
    add_column :orders,:returning_status,:string
    add_column :orders,:shippability_status,:string
    add_column :orders,:backordering_status,:string
    add_column :orders,:tax_treatment,:string
    add_column :orders,:issued_at,:date
    add_column :orders,:ship_at,:date
    add_column :orders,:tax_label,:string
    add_column :orders,:source_url,:string
    add_column :orders,:document_url,:string
    add_column :orders,:total,:string
    add_column :orders,:tracking_number,:string
  end
end
