class AddAttributesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string
    add_column :users, :name, :string
    add_column :users, :socials, :jsonb, default: {} # JSONB may be tricky to call (no symbol ?)
    add_column :users, :phone, :string
    add_column :users, :members, :jsonb, default: {} # JSONB may be tricky to call (no symbol ?)
    add_column :users, :description, :text
    add_column :users, :avatar, :string
    add_column :users, :banner, :string
    add_column :users, :city, :string
    add_column :users, :style, :string
  end
end
