class ChangeIsLockedToBoolean < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :is_locked, :boolean, using: 'is_locked::boolean', default: false
  end
end
