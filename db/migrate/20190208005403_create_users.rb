class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :location
      t.float :trade_completion
      t.integer :trade_slots

      t.timestamps
    end
  end
end
