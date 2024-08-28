class ChangeColumnsOfEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :category, :string
    add_column :events, :style, :string
    add_column :events, :end_date, :datetime
  end
end
