class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :nickname
      t.string :instrument
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    remove_column :users, :members
  end
end
