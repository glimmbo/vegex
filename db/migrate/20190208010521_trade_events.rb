class TradeEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :trade_events do |t|
      t.string :type, null: false
      t.integer :trade_id, null: false

      t.text :data, null: false
      t.text :metadata, null: false
      t.datetime :created_at, null: false

      t.index :trade_id
    end
  end
end
