class AddStatusToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :status, :string, default: 'pending'
  end
end
