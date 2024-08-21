class AddAttributesToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :name, :string
    add_column :events, :description, :string
    add_column :events, :start_date, :datetime
    add_column :events, :number_of_acts, :integer
    add_reference :events, :venue, foreign_key: true
    add_column :events, :status, :string
  end
end
