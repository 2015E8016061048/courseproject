class RemoveBirthdayFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :birthday, :string
  end
end
