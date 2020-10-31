class AddNamesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :shortname, :string
    add_column :users, :fullname, :string
  end
end
