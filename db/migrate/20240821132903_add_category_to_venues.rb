class AddCategoryToVenues < ActiveRecord::Migration[7.1]
  def change
    add_column :venues, :category, :string
  end
end
