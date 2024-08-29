class AddAttributeToStyles < ActiveRecord::Migration[7.1]
  def change
    add_column :styles, :content, :string
    add_reference :styles, :user, foreign_key: true
  end
end
