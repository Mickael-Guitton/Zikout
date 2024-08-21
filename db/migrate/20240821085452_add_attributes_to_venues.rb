class AddAttributesToVenues < ActiveRecord::Migration[7.1]
  def change
    add_column :venues, :name, :string
    add_column :venues, :address, :string
    add_column :venues, :description, :string
    add_column :venues, :lodging, :string
    add_column :venues, :scene_size, :string
    add_column :venues, :paying, :string
    add_column :venues, :capacity, :integer
    add_reference :venues, :user, foreign_key: true
  end
end
