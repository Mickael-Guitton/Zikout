class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.boolean :read
      t.string :notification_type
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
