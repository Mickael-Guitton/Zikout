class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :demands, :string
    add_column :users, :public_email, :boolean, using: 'public_email::boolean', default: false
    add_column :users, :inspiration, :string
    add_column :users, :website, :string
    add_column :users, :yt_links, :jsonb, default: []
    remove_column :users, :avatar
    remove_column :users, :banner
    change_column :users, :members, :jsonb, default: [{ nom: "", instrument: "" }]
    remove_column :users, :socials
    add_column :users, :facebook, :string
    add_column :users, :instagram, :string
    add_column :users, :listen_to_us, :string
  end
end
