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
    change_column :users, :socials, :jsonb, default: { facebook: "", instagram: "", listen_to_us: "" }
  end
end
