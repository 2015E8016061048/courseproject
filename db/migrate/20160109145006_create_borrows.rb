class CreateBorrows < ActiveRecord::Migration
  def change
    create_table :borrows do |t|
      t.integer :user_id
      t.integer :device_id
      t.datetime :borrowtime
      t.datetime :ordertime
      t.datetime :givebacktime

      t.timestamps null: false
    end
  end
end
