class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :range
      t.text :about
      t.float :completion
      t.integer :slots

      t.timestamps
    end
  end
end
