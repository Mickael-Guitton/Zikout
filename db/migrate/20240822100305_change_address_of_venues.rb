class ChangeAddressOfVenues < ActiveRecord::Migration[7.1]
  def change
    remove_column :venues, :address
    add_column :venues, :street, :string
    add_column :venues, :city, :string
    add_column :venues, :zipcode, :string
    add_column :venues, :country, :string
  end
end
