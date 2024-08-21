class AddStylesColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :styles, :jsonb, default: []
  end
end
