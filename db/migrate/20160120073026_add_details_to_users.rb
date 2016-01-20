class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :birthday, :string
    add_column :users, :sex, :string
    add_column :users, :department, :string
    add_column :users, :mobile, :string
    add_column :users, :telephone, :string
  end
end
