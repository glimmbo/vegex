class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.references :user
      t.string :produce
      t.integer :quantity
      t.integer :offer_user_id
      t.string :offer_produce
      t.integer :offer_quantity

      t.timestamps
    end
  end
end
