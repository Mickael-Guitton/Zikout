class RemoveStyleFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :style
  end
end
