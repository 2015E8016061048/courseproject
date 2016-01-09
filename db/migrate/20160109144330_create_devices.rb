class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.text :description
      t.string :kind
      t.string :department
      t.string :statement

      t.timestamps null: false
    end
  end
end
