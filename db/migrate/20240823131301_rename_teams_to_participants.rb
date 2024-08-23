class RenameTeamsToParticipants < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up do
        rename_table :teams, :participants
      end
      dir.down do
        rename_table :participants, :teams
      end
    end
  end
end
