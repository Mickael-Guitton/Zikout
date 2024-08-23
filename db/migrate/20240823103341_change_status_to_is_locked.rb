class ChangeStatusToIsLocked < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :status, :is_locked
  end
end
