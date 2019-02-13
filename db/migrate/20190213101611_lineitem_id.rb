class LineitemId < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items , :lineitem_id, :integer
  end
end
